//
//  LandingRouter.swift
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

@objc protocol LandingRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    func routeToLogin()
    func routeToSignup()
    func routeToTabBar()
}

protocol LandingDataPassing
{
    var dataStore: LandingDataStore? { get }
}

class LandingRouter: NSObject, LandingRoutingLogic, LandingDataPassing
{
    weak var viewController: LandingViewController?
    var dataStore: LandingDataStore?
    
    // MARK: Routing
    
    func routeToLogin() {
        let storyboard = UIStoryboard(name: "UniversalStoryboard", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
    
    func routeToSignup() {
        let storyboard = UIStoryboard(name: "UniversalStoryboard", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        navigateToSomewhere(source: viewController!, destination: destinationVC)
    }
    
    func routeToTabBar() {
        ApplicationDelegate.setTabBarAsRootViewController()
    }
    
    // MARK: Navigation
    
    func navigateToSomewhere(source: LandingViewController, destination: UIViewController)
    {
        source.navigationController?.pushViewController(destination, animated: false)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: LandingDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
