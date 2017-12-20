//
//  LoginViewController.swift
//  aywa
//
//  Created by Bestpeers on 18/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit



protocol LoginDisplayLogic: class
{
    func displayError(response: Landing.JWTToken.Response)
    func displayHomeScreen()
    
}

class LoginViewController: UIViewController, LoginDisplayLogic
{
    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
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
    
    // MARK: Setup
    
    private func initialSetup() {
        setup()
    }
    
    private func setup()
    {
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        emailTextField.text = "test_user1@gmail.com"
        passwordTextField.text = "123456"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    // MARK: Do Login
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    //MARK: Login 
    @IBAction func loginButtonTapped(_ sender: Any) {
        doLogin()
    }
    
    func doLogin()
    {
        let request = Login.Signin.Request(email: emailTextField.text, password: passwordTextField.text, deviceIdentifier: Utils.deviceIdentifier(), deviceType: Utils.deviceType())
        interactor?.doLogin(request: request)
    }
    
    func displayError(response: Landing.JWTToken.Response)
    {
        print("Error occured: \(response.message!)")
    }
    
    func displayHomeScreen()
    {
        print("Show Home Screen!!!")
        router?.routeToTabBar(segue: nil)
    }
    
    
}
