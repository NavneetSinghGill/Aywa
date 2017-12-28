//
//  BPViewControllerExtension.swift
//  aywa
//
//  Created by Apple on 28/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import Foundation
import BPViewsSubviewsInOutAnimation

extension BPViewController {
    
    @objc override func backButtonTapped() {
        if self.navigationController != nil {
            self.bpPopViewController()
        }
    }
}
