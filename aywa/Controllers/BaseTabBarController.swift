//
//  BaseTabBarController.swift
//  aywa
//
//  Created by Apple on 27/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    let numberOfTabs: CGFloat = 5
    let tabBarHeight: CGFloat = 50
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateSelectionIndicatorImage()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        updateSelectionIndicatorImage()
    }
    
    func updateSelectionIndicatorImage() {
        let width = tabBar.bounds.width
        let height = tabBar.bounds.height
        var selectionImage = UIImage(named:"SelectedTab")
        let tabSize = CGSize(width: width/numberOfTabs, height: height)
        
        UIGraphicsBeginImageContext(tabSize)
        selectionImage?.draw(in: CGRect(x: 0, y: 0, width: tabSize.width, height: tabSize.height))
        selectionImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        tabBar.selectionIndicatorImage = selectionImage
    }
    
}
