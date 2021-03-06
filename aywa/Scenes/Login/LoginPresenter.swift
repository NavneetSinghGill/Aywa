//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic
{
    func presentError(response: Token.JWTToken.Response)
    func presentNextScreen()
}

class LoginPresenter: LoginPresentationLogic
{
  weak var viewController: LoginDisplayLogic?
  
  // MARK: Do Login
  
    func presentError(response: Token.JWTToken.Response)
    {
        viewController?.displayError(response: response)
    }
    
    func presentNextScreen()
    {
        viewController?.displayHomeScreen()
    }
   
}
