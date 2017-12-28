//
//  LoginViewController.swift
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
import BPViewsSubviewsInOutAnimation
import SVProgressHUD

protocol LoginDisplayLogic: class
{
    func displayError(response: Landing.JWTToken.Response)
    func displayHomeScreen()
    
}

class LoginViewController: BPViewController, LoginDisplayLogic, UITextFieldDelegate
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
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeBackgroundImage(notification:)), name: Notification.Name(Constants.kChangeBackgroundImageIdentifier), object: nil)
        setup()
    }
    
    private func initialiseView() {
        
        backgroundImageView.image = BackgroundImageManager.shared().backgroundImage
        self.title = "Signin"
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        emailTextField.text = "test_user1@gmail.com"
        passwordTextField.text = "123456"
        showNavigationBar()
        updateNavigationBar()
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
        initialiseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Do Login
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emailTextField: FloatingHeaderTextField!
    @IBOutlet weak var passwordTextField: FloatingHeaderTextField!
    
    //MARK: Login 
    @IBAction func loginButtonTapped(_ sender: Any) {
        doLogin()
    }
    //MARK: Facebook Login Button Tapped
    @IBAction func facebookLoginButtonTapped(_ sender: Any) {
        print("Facebook Login Button Tapped !!!")
    }
    //MARK: Fogot Password Button Tapped
    @IBAction func fogotPasswordButtonTapped(_ sender: Any) {
        print("Fogot Password Button Tapped !!!")
    }
    func doLogin()
    {
     SVProgressHUD.setForegroundColor(UIColor.init(red: 253.0/255.0, green: 2.0/255.0, blue: 45/255.0, alpha: 1))
        //SVProgressHUD.show()
        SVProgressHUD.show(withStatus: "Signin")
        let request = Login.Signin.Request(email: emailTextField.text, password: passwordTextField.text, deviceIdentifier: Utils.deviceIdentifier(), deviceType: Utils.deviceType())
        interactor?.doLogin(request: request)
    }
    
    func displayError(response: Landing.JWTToken.Response)
    {
        SVProgressHUD.dismiss()
        print("Error occured: \(response.message!)")
    }
    
    func displayHomeScreen()
    {
        SVProgressHUD.dismiss()
        print("Show Home Screen!!!")
        router?.routeToTabBar(segue: nil)
    }
    
    //MARK:- TextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func changeBackgroundImage(notification: Notification?){
        //Take Action on Notification
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroundImageView.alpha = 0.7
            }, completion: { (complete) in
                self.backgroundImageView.image = BackgroundImageManager.shared().backgroundImage
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.backgroundImageView.alpha = 1
                }, completion: nil)
            })
        }
    }
}
