//
//  AppFont.swift
//  aywa
//
//  Created by Best Peers on 11/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

extension UIButton {
    
    func appBoldFont() {
        self.titleLabel?.font = UIFont(name: "Helvetica-Black_cyr-Bold", size: (self.titleLabel?.font?.pointSize)!)
    }

}
