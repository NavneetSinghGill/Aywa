//
//  LoginRouter.swift
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

@objc protocol LoginRoutingLogic
{
    func routeToTabBar(segue: UIStoryboardSegue?)
    func routeToForgotPassword()
}

protocol LoginDataPassing
{
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing
{
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
    
    // MARK: Routing
    
    func routeToForgotPassword() {
        let destinationVC = ForgotPasswordViewController.create(of: .UniversalStoryboard)
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
    
    func routeToTabBar(segue: UIStoryboardSegue?)
    {
        ApplicationDelegate.setTabBarAsRootViewController()
    }
    
    // MARK: Navigation
    
    func navigateToSomewhere(source: LoginViewController, destination: UIViewController)
    {
        source.bpPush(viewController: destination)
    }
}
