//
//  LandingContentViewController.swift
//  aywa
//
//  Created by Zoeb on 11/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class LandingContentViewController: UIViewController {
    var pageIndex: Int = 0
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var initialHeaderView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var upperLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func setup(){
        initialHeaderView.isHidden = pageIndex != 0
        upperLogo.isHidden = pageIndex == 0 || pageIndex == 3
        subtitleLabel.text = "Movies & TV Shows\nOn demand"
        backgroundImageView.image = pageIndex == 0 ? UIImage(named: "pageContentImage1")
            : pageIndex == 1 ?  UIImage(named: "pageContentImage2") : pageIndex == 2 ?  UIImage(named: "pageContentImage3") :  UIImage(named: "pageContentImage4")
    }
    
}
