//
//  SignupInteractor.swift
//  aywa
//
//  Created by Zoeb on 16/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SignupBusinessLogic
{
    func doSignup(request: Signup.Register.Request)
    func doRegisterFacebook()
}

protocol SignupDataStore
{
    //var name: String { get set }
}

class SignupInteractor: SignupBusinessLogic, SignupDataStore
{
    var presenter: SignupPresentationLogic?
    var worker: SignupWorker?
    var securityStorageWorker = SecurityStorageWorker()
    var facebookWorker = FacebookWorker()
    
    // MARK: Do Signup
    
    func doSignup(request: Signup.Register.Request)
    {
        if isDataValid(request: request) {
            worker = SignupWorker()
            worker?.register(request: request, success: { (response) in
                print(response)
                if self.securityStorageWorker.storeAccessTokenResponse(response: response) {
                    self.securityStorageWorker.updateLoggedInState(isLoggedIn: true)
                    self.presenter?.presentNextScreen()
                }
                
            }, fail: { (response) in
                self.presenter?.presentError(response: response)
                
            })
        }
        else{
            return (presenter?.presentError(response: Token.JWTToken.Response(message: "This field is required.")!))!
        }
        
    }
    
    // MARK:- Validation For Signup Request
    private func isDataValid(request: Signup.Register.Request) -> Bool {
        var isValid = false
        var errorMsg : String?
        
        if request.email == nil || request.password == nil || request.name == nil || request.ageGroup == nil || request.gender == nil {
            //print("This field is required.")
            errorMsg = "Field required".localize()
        }
        else if ((request.name!.count) < 1)
        {
            errorMsg = "Field required".localize()
        }
        else if ((request.email!.count) < 1)
        {
            errorMsg = "Field required".localize()
        }
        else if !(Utils.isValid(email: (request.email)!))
        {
            errorMsg =  "Email addrees invalid".localize()
        }
        else if ((request.password!.count) < 5)
        {
            errorMsg = "Password should be at least 8 characters long.".localize()
            //"Password field may not be empty and must be minimum 5 length."
        }
      /*  else if ((request.confirmPassword!.count) < 5)
        {
            errorMsg = "Password is too short."
        }
        else if !( request.password! .isEqual(request.confirmPassword!) ) {
            errorMsg = "Confirm Password and Password field  not match."
        }
             */ // TODO: for confirm Password remove on ui
        else if !(request.birthday == nil )
        {
            //            if !(request.birthday == nil )
            //            {
            //                errorMsg = "Birthday field may not be empty."
            //            } // TODO: date formate validation
        }
        else if ((request.ageGroup!.count) < 1){
            errorMsg = "Field required".localize()     //"This field is required."
        }
        else if ((request.gender!.count) < 1){
            errorMsg = "Field required".localize()
        }
        else if !(request.country == nil){
            if ((request.country!.count) < 1){
                errorMsg =  "Country field may not be empty."
            }
        }
        else if !(request.countryName == nil){
            if ((request.countryName!.count) < 1){
                errorMsg = "Country Name field required".localize()
            }        }
        else if !(request.phone == nil){
            if ((request.phone!.count) < 10){
                errorMsg = "PhoneNumberTooShortMessage".localize()
            }
        }
            
        else {
            isValid = true
            
        }
        if(!isValid && errorMsg!.count > 0) {
            //Utils.showAlertWith(title: "Oops!", message: errorMsg!, inController: SignupInteractor)
            //BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: errorMsg!)
           // print(errorMsg!)
        }
        return isValid
    }
    //MARK: Do Register Facebook
    func doRegisterFacebook() {
        var requestForFacebook: Signup.Register.RegisterFacebookRequest!
        
        worker = SignupWorker()
        self.facebookWorker.doFacebookLogin { (token) in
            print(token.count)
            let fbToken = token[Constants.kFbToken]
            if token.count > 1{
                requestForFacebook = Signup.Register.RegisterFacebookRequest(token: fbToken! as? String, email: token[Constants.kEmailKey] as? String, deviceIdentifier: Utils.deviceIdentifier(), deviceType: Utils.deviceType())
            }
            else{
                requestForFacebook = Signup.Register.RegisterFacebookRequest(token: fbToken! as? String, email: "", deviceIdentifier: Utils.deviceIdentifier(), deviceType: Utils.deviceType())
            }
            self.worker?.registerFacebook(request: requestForFacebook, success: { (response) in
                print(response)
                if self.securityStorageWorker.storeAccessTokenResponse(response: response){
                    self.presenter?.presentNextScreen()
                }
            }, fail: { ( response) in
                self.presenter?.presentError(response: response)
            })
        }
    }
}
