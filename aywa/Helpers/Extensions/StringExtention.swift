//
//  StringExtention.swift
//  aywa
//
//  Created by Zoeb  on 16/01/18.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import Foundation

extension String {
    
    func localize() -> String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
    
}
