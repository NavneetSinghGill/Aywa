//
//  SwipeViewController.swift
//  aywa
//
//  Created by Navneet Singh on 19/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var contentViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topView: UIView!
    
    var defaultTopViewTopValue : CGFloat = 0
    var defaultContentViewTopValue : CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        defaultTopViewTopValue = topViewTopConstraint.constant
        defaultContentViewTopValue = contentViewTopConstraint.constant
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentViewTopConstraint.constant - contentOffsetY < topView.bounds.size.height {
            topViewTopConstraint.constant = defaultTopViewTopValue + contentOffsetY/2
            contentViewTopConstraint.constant = defaultContentViewTopValue
        }

    }

}
