//
//  ForgotPasswordViewController.swift
//  aywa
//
//  Created by Bestpeers on 29/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ForgotPasswordDisplayLogic: class
{
    //func displayError(response:ForgotPassword.ResetPasswod.Response )
    // func displayForgotPasswordResponse(response:ForgotPassword.ResetPasswod.Response )
    
    func displayError(response: Common.Response)
    func displayForgotPasswordResponse()
}

class ForgotPasswordViewController: UIViewController, ForgotPasswordDisplayLogic,UITextFieldDelegate
{
    var interactor: ForgotPasswordBusinessLogic?
    var router: (NSObjectProtocol & ForgotPasswordRoutingLogic & ForgotPasswordDataPassing)?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
        initialSetup()
    }
    
    // MARK: Setup
    
    private func initialSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeBackgroundImage(notification:)), name: Notification.Name(Constants.kChangeBackgroundImageIdentifier), object: nil)
        setup()
    }
    
    private func initialiseView() {
        
        backgroundImageView.image = BackgroundImageManager.shared().backgroundImage
        self.emailTextField.delegate = self
        showNavigationBar()
        navigationBarWithLeftSideTitle(isTitle: false, titleName: " Reset password")
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ForgotPasswordInteractor()
        let presenter = ForgotPasswordPresenter()
        let router = ForgotPasswordRouter()
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
    
    // MARK: Do Reset Password
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var emailTextField: FloatingHeaderTextField!
    @IBAction func resetPasswordButtonTapped(_ sender: Any){
        doResetPassword()
    }
    
    func doResetPassword()
    {
        let request = ForgotPassword.ResetPasswod.Request(email: self.emailTextField.text)
        interactor?.doForgottenPassword(request: request)
    }
    
    func displayError(response: Common.Response) {
        print(response.message!)
    }
    
    func displayForgotPasswordResponse() {
        print("Get ForgotPassword data !!!!!!")
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
