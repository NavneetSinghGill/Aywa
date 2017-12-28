//
//  LoginInteractor.swift
//  aywa
//
//  Created by Zoeb on 18/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol LoginBusinessLogic
{
    func doLogin(request: Login.Signin.Request)
}

protocol LoginDataStore
{
    //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var presenter: LoginPresentationLogic?
    var worker: LoginWorker?
    var securityStorageWorker = SecurityStorageWorker()

    // MARK:- Do Login
    func doLogin(request: Login.Signin.Request)
    {
        if isLoginValidation(request: request) {
            worker = LoginWorker()
            worker?.signin(request: request, success: { (response) in
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
            return (presenter?.presentError(response: Landing.JWTToken.Response(message: "Fields may not be empty.")!))!
        }

    }
    //MARK:- Validation For Login Request
    func isLoginValidation(request:Login.Signin.Request ) -> Bool {
        var isValid = false
        var errorMsg : String?
        if request.email == nil || request.password == nil {
            print("This field is required.")
        }
        else if ((request.email!.count) < 1)
        {
            errorMsg = "This field is required."
        }
        else if !(Utils.isValid(email: (request.email)!))
        {
            errorMsg = "Invalid email address/password combination."
        }
        else if ((request.password!.count) < 5)
        {
            errorMsg = "Password is too short."
        }
            
        else {
            isValid = true
        }
        if(!isValid && errorMsg!.count > 0) {
            print(errorMsg!)
        }
        return isValid
        
        
    }
}
