//
//  ForgotPasswordInteractor.swift
//  aywa
//
//  Created by Bestpeers on 29/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ForgotPasswordBusinessLogic
{
    func doForgottenPassword(request: ForgotPassword.ResetPasswod.Request)
}

protocol ForgotPasswordDataStore
{
    //var name: String { get set }
}

class ForgotPasswordInteractor: ForgotPasswordBusinessLogic, ForgotPasswordDataStore
{
    var presenter: ForgotPasswordPresentationLogic?
    var worker: ForgotPasswordWorker?
    
    // MARK: Do Forgot password
    
    func doForgottenPassword(request: ForgotPassword.ResetPasswod.Request)
    {
        
        if isDataValid(request: request) {
            worker = ForgotPasswordWorker()
            worker?.doForgottenPasswordWork(request: request, success: { (response) in
                print(response)
                self.presenter?.presentNewPasswordScreen()
            }, fail: { (response) in
                 self.presenter?.presentError(response: response)
            })
        }
        else{
          return (presenter?.presentError(response: Common.Response(message: "Fields may not be empty.")!))!
        }
    }
    
    // MARK:- Validation For Signup Request
    private func isDataValid(request: ForgotPassword.ResetPasswod.Request) -> Bool {
        var isValid = false
        var errorMsg : String?
        
        if request.email == nil {
            print("This field is required.")
        }
        else if !(Utils.isValid(email: (request.email)!))
        {
            errorMsg = "This email address is invalid."
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
