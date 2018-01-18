//
//  DropDownExtension.swift
//  aywa
//
//  Created by Zoeb on 18/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import Foundation
import DropDown

extension DropDown {
    
    func localise() {
        if self.effectiveUserInterfaceLayoutDirection == .rightToLeft {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            for subView in self.subviews {
                subView.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
        }
    }
    
    func showWithLocalisation() {
        self.show()
        self.localise()
    }
    
}
