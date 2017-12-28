//
//  BackgroundImageManager.swift
//  aywa
//
//  Created by Zoeb on 26/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import Foundation

class BackgroundImageManager {
    
    // MARK: - Properties
    private static var sharedBackgroundImageManager: BackgroundImageManager = {
        let backgroundImageManager = BackgroundImageManager()
        
        // Configuration
        // ...
        
        return backgroundImageManager
    }()
    
    
    let pageContentImage = "pageContentImage"
    var backgroundImage: UIImage?
    var selectedImageIndex:Int = 1
    let imageIndexCount = 5
    var timer:Timer?
    
    // MARK: - Initialization
    
    private init() {
        self.backgroundImage = UIImage(named:pageContentImage + "\(1)")
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(BackgroundImageManager.changeImage), userInfo: nil, repeats: true)
    }
    
    // MARK: - Accessors
    
    class func shared() -> BackgroundImageManager {
        return sharedBackgroundImageManager
    }
    
    // MARK: - Public
    
    func restartTimer(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: #selector(BackgroundImageManager.changeImage), userInfo: nil, repeats: true)
    }
    
    // MARK: - Private
    
    @objc func changeImage()
    {
        if selectedImageIndex == imageIndexCount {
            selectedImageIndex = 1
        }
        else {
            selectedImageIndex = selectedImageIndex + 1
        }
        
        backgroundImage = UIImage(named:pageContentImage + "\(selectedImageIndex)")
        NotificationCenter.default.post(name: Notification.Name(Constants.kChangeBackgroundImageIdentifier), object: nil, userInfo: nil)
    }
}
