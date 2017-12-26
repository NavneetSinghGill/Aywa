//
//  SignupViewController.swift
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
import BPViewsSubviewsInOutAnimation
protocol SignupDisplayLogic: class
{
    func displayError(response: Landing.JWTToken.Response)
    func displayHomeScreen()
}

class SignupViewController: BPViewController, SignupDisplayLogic
{
    var interactor: SignupBusinessLogic?
    var router: (NSObjectProtocol & SignupRoutingLogic & SignupDataPassing)?
    
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
        //        NotificationCenter.default.addObserver(self, selector: #selector(self.changeBackgroundImage(notification:)), name: Notification.Name(Constants.kChangeBackgroundImageIdentifier), object: nil)
        setup()
    }
    
    private func setup()
    {
        let viewController = self
        let interactor = SignupInteractor()
        let presenter = SignupPresenter()
        let router = SignupRouter()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    // MARK: Do signup
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var ageGroupTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
//    @IBOutlet weak var backgroundImageView: UIImageView
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
       doSignup()
    }
    
    func doSignup()
    {
        let request = Signup.Register.Request(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text,  name: nameTextField.text, deviceIdentifier: Utils.deviceIdentifier(), deviceType: Utils.deviceType(), birthday: nil, ageGroup: ageGroupTextField.text, gender: genderTextField.text, country: nil, countryName: nil, phone: nil, ipAddress: nil)
        interactor?.doSignup(request: request)
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
    
    @objc func changeBackgroundImage(notification: Notification?){
        //Take Action on Notification
        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.5, animations: {
//                self.backgroundImageView.alpha = 0
//            }, completion: { (complete) in
//                self.backgroundImageView.image = BackgroundImageManager.shared().backgroundImage
//                UIView.animate(withDuration: 0.5,
//                               delay: 0,
//                               options: .curveEaseInOut,
//                               animations: {
//                                self.backgroundImageView.alpha = 1
//                }, completion: nil)
//            })
        }
    }
}
