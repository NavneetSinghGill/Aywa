//
//  TokenManager.swift
//  aywa
//
//  Created by Apple on 29/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TokenDisplayLogic: class
{
    func displayError(response: Token.JWTToken.Response)
    func displayNextScreen()
}

class TokenManager: NSObject, TokenDisplayLogic
{
    var tokenBlock: CompletionHandler = { _,_ in }
    var interactor: TokenBusinessLogic?
    
    // MARK: - Properties
    private static var sharedTokenManager: TokenManager = {
        let tokenManager = TokenManager()
        
        // Configuration
        // ...
        
        return tokenManager
    }()
    
    // MARK: - Initialization
    
    private override init() {
        super.init()
        setup()
    }
    
    // MARK: - Accessors
    
    class func shared() -> TokenManager {
        return sharedTokenManager
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let tokenManager = self
        let interactor = TokenInteractor()
        let presenter = TokenPresenter()
        tokenManager.interactor = interactor
        interactor.presenter = presenter
        presenter.tokenManager = tokenManager
    }
    
    // MARK: fetch token
    
    func fetchToken(completion: @escaping CompletionHandler) -> Void
    {
        self.tokenBlock = completion
        let request = Token.JWTToken.Request()
        interactor?.fetchToken(request: request)
    }
    
    func displayError(response: Token.JWTToken.Response)
    {
        print("Error occured: \(response)")
        self.tokenBlock(false, response)
    }
    
    func displayNextScreen()
    {
        print("Show Next Screen!!!")
        self.tokenBlock(true, nil)
    }
}
