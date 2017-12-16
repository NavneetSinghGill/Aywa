//
//  Utils.swift
//  aywa
//
//  Created by Best Peers on 16/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    class func deviceIdentifier() -> String {
        return UserDefaults.standard.string(forKey: Constants.deviceIdentifier) ?? (UIDevice.current.identifierForVendor?.uuidString)!
    }
    
    class func deviceType() -> Int {
        return 1 // 1 for mobile
    }

}
