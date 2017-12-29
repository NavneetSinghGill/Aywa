//
//  SplashViewController.swift
//  aywa
//
//  Created by Apple on 29/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialSetup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        initialSetup()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func initialSetup() {
        
        // fetch token from Token Manager
        TokenManager.shared().fetchToken { (status, response) in
            print("Status:\(status) \nResponse:\(response ?? "NIL")")
            
            DispatchQueue.main.async {
                if status {
                    ApplicationDelegate.setTabBarAsRootViewController()
                }
                else{
                    ApplicationDelegate.setLandingAsRootViewController()
                }
            }
        }
    }
}
