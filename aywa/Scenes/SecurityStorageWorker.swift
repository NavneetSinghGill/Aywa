//
//  SecurityStorageWorker.swift
//  aywa
//
//  Created by Bestpeers on 14/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SecurityStorageWorker: NSObject {


    // Mark:- Set Keychain Value
    public func setValue(_ value: String, keyValue: String) -> Bool {
        KeychainWrapper.standard.set(value, forKey: keyValue)
        if let boolValue: Bool = KeychainWrapper.standard.set(value, forKey: keyValue)  {
            return boolValue
        }
        else{
            return false
        }
    }


    //MARK:- Get Keychain Value
    public func getKeychainValue(keyValueIs: String) -> String {
        let stringValueIs = KeychainWrapper.standard.string(forKey: keyValueIs)
        return stringValueIs!
    }

    //MARK:- Update Keychain Value
    public func updateKeychainValue(valueIs: String, keyValue: String) -> Bool {
        if let data = valueIs.data(using: .utf8) {
            if let data: Bool = KeychainWrapper.standard.update(data, forKey: keyValue){
                return data
            }
        }
        else{
            return false
        }
    }
}
