//
//  MyListViewController.swift
//  aywa
//
//  Created by Bestpeers on 09/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var moviesButton: UIButton!
    @IBOutlet weak var tvButton: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var constantViewLeft: NSLayoutConstraint!
    
    private var pageController: UIPageViewController!
    private var arrVC:[UIViewController] = []
    private var currentPage: Int!
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialiseView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Initial Setup
    private func initialiseView() {
        navigationBarWithLeftSideTitle(isTitle: true, titleName: "My List")
    }
    
    //MARK: - Custom Methods
    
    private func selectedButton(btn: UIButton) {
        
        //btn.setTitleColor(UIColor.black, for: .normal)
        constantViewLeft.constant = btn.frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func unSelectedButton(btn: UIButton) {
        btn.setTitleColor(UIColor.red, for: UIControlState.normal)
    }
    //MARK: - IBaction Methods
    @IBAction private func btnOptionTapped(btn: UIButton) {
        resetTabBarForTag(tag: btn.tag-1)
    }
    //MARK: - Set Top bar after selecting Option from Top Tabbar
    
    private func resetTabBarForTag(tag: Int) {
        
        var sender: UIButton!
        
        if(tag == 0) {
            sender = moviesButton
        }
        else if(tag == 1) {
            sender = tvButton
        }
        else if(tag == 2) {
            //sender = btnTab3
        }
        
        currentPage = tag
        
        unSelectedButton(btn: moviesButton)
        unSelectedButton(btn: tvButton)
        //        unSelectedButton(btn: btnTab3)
        
        self.selectedButton(btn: sender)
        
    }
    
    //MARK: - UIScrollView Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let xFromCenter: CGFloat = self.view.frame.size.width-scrollView.contentOffset.x
        let xCoor: CGFloat = CGFloat(viewLine.frame.size.width) * CGFloat(currentPage)
        let xPosition: CGFloat = xCoor - xFromCenter/CGFloat(arrVC.count)
        constantViewLeft.constant = xPosition
    }
}
