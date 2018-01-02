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
import DropDown

protocol SignupDisplayLogic: class
{
    func displayError(response: Token.JWTToken.Response)
    func displayHomeScreen()
}

class SignupViewController: BPViewController, SignupDisplayLogic, UITextFieldDelegate
{
    static let kMale = "Male"
    static let kFemale = "Female"
    static let kOther = "Other"
    
    var interactor: SignupBusinessLogic?
    var router: (NSObjectProtocol & SignupRoutingLogic & SignupDataPassing)?
    var backBarButton: UIBarButtonItem!
    // DropDowns
    let ageDropDown = DropDown()
    let genderDropDown = DropDown()
    
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
        self.navigationItem.hidesBackButton = true
       
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmPasswordTextField.delegate = self
        self.ageGroupTextField.delegate = self
        self.genderTextField.delegate = self
        setupDropDowns()
        showNavigationBar()
        //updateNavigationBar()
        navigationBarWithLeftSideTitle(isTitle: false, titleName: "Sign up")
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
        initialiseView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: Do signup
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var nameTextField: FloatingHeaderTextField!
    @IBOutlet weak var emailTextField: FloatingHeaderTextField!
    @IBOutlet weak var passwordTextField: FloatingHeaderTextField!
    @IBOutlet weak var confirmPasswordTextField: FloatingHeaderTextField!
    @IBOutlet weak var ageGroupTextField: FloatingHeaderTextField!
    @IBOutlet weak var genderTextField: FloatingHeaderTextField!
    
    //    @IBOutlet weak var backgroundImageView: UIImageView
    
    //MARK: Signup Button Tapped
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        doSignup()
    }
    //MARK:Create Account With Facebook Id Button Tapped
    @IBAction func createAccountWithFacebookIdButtonTapped(_ sender: Any) {
        print("Create Account WithFacebook Id Button Tapped !!!")
        doFackbookSignup()
    }
    //MARK: - Setup Drop Down
    
    func setupDropDowns() {
        setupGenderDropDown()
        setupAgeDropDown()
    }
    // MARK: Age Drop Down
    func setupAgeDropDown() {
        ageDropDown.anchorView = ageGroupTextField
        ageDropDown.direction = .top
        ageDropDown.topOffset = CGPoint(x: 0, y: -(ageGroupTextField.bounds.height+10))
        ageDropDown.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
        ageDropDown.textColor = UIColor.white
        ageDropDown.dataSource = [
            "14-18",
            "19-24",
            "24-35",
            "36-44",
            "45+"
        ]
        
        // Action triggered on selection
        ageDropDown.selectionAction = { [weak self] (index, item) in
            self?.ageGroupTextField.text = item
        }
    }
    //MARK: Gender Drop Down
    func setupGenderDropDown() {
        genderDropDown.anchorView = genderTextField
        genderDropDown.bottomOffset = CGPoint(x:0, y: genderTextField.bounds.height)
               genderDropDown.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1.0)
              genderDropDown.textColor = UIColor.white
        genderDropDown.dataSource = [
            SignupViewController.kMale,
            SignupViewController.kFemale,
            SignupViewController.kOther
        ]
        // Action triggered on selection
        genderDropDown.selectionAction = {[weak self] (Index, item) in
            self?.genderTextField.text = item
        }
    }
    
    //MARK:- TextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == ageGroupTextField{
            ageGroupTextField.isActive = true
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.resignFirstResponder()
            ageGroupTextField.resignFirstResponder()
            ageDropDown.show()
            ageDropDown.direction = .top
            return false
        }
        else if textField == genderTextField {
            genderTextField.isActive = true
            
            emailTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            confirmPasswordTextField.resignFirstResponder()
            genderTextField.resignFirstResponder()
            genderDropDown.show()
            genderDropDown.direction = .bottom
            return false
        }
        else{
            return true
        }
    }
    //MARK: Do Signup Request
    func doSignup()
    {
        let request = Signup.Register.Request(email: emailTextField.text, password: passwordTextField.text, confirmPassword: confirmPasswordTextField.text,  name: nameTextField.text, deviceIdentifier: Utils.deviceIdentifier(), deviceType: Utils.deviceType(), birthday: nil, ageGroup: ageGroupTextField.text, gender: genderTextField.text == SignupViewController.kMale ? "M" : genderTextField.text == SignupViewController.kFemale ? "F" : "?", country: nil, countryName: nil, phone: nil, ipAddress: nil)
        interactor?.doSignup(request: request)
    }
    
    //MARK: Do Facebook Signup Request
    func doFackbookSignup() {
        interactor?.doRegisterFacebook()
    }
    func displayError(response: Token.JWTToken.Response)
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
