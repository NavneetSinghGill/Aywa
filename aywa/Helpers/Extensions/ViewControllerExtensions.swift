//
//  ViewControllerExtensions.swift
//  aywa
//
//  Created by Zoeb on 16/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK:- Back button action
    
    func updateNavigationBar() {
        self.updateNavigationBarColor()
        self.updateBackButton()
    }
    
    func updateNavigationBarColor() {
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 51.0/255.0, green: 51.0/255.0, blue: 51.0/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Helvetica", size: 18)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]

    }
    
    func updateBackButton() {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let backBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = backBarButton
    }
    
    @objc func backButtonTapped() {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}
