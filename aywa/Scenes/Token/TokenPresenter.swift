//
//  TokenPresenter.swift
//  aywa
//
//  Created by Zoeb on 11/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TokenPresentationLogic
{
    func presentError(response: Token.JWTToken.Response)
    func presentNextScreen()
}

class TokenPresenter: TokenPresentationLogic
{
    weak var tokenManager: TokenDisplayLogic?
    
    // MARK: Fetch Token
    
    func presentError(response: Token.JWTToken.Response)
    {
        tokenManager?.displayError(response: response)
    }
    
    func presentNextScreen()
    {
        tokenManager?.displayNextScreen()
    }
}

