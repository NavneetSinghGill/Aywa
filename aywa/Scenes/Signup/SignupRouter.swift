//
//  SignupRouter.swift
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

@objc protocol SignupRoutingLogic
{
    func routeToTabBar(segue: UIStoryboardSegue?)
}

protocol SignupDataPassing
{
  var dataStore: SignupDataStore? { get }
}

class SignupRouter: NSObject, SignupRoutingLogic, SignupDataPassing
{
  weak var viewController: SignupViewController?
  var dataStore: SignupDataStore?
  
  // MARK: Routing
  
    func routeToTabBar(segue: UIStoryboardSegue?)
    {
        ApplicationDelegate.setTabBarAsRootViewController()
    }
    
    // MARK: Navigation
    
    func navigateToSomewhere(source: SignupViewController, destination: UITabBarController)
    {
        source.show(destination, sender: nil)
    }
}
