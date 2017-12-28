//
//  SecurityStorageWorker.swift
//  aywa
//
//  Created by Zoeb on 14/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SecurityStorageWorker: NSObject {


    // Mark:- Set Keychain Value
    public func setTokenValue(_ value: String, key: String) -> Bool {
        return KeychainWrapper.standard.set(value, forKey: key)
    }

    //MARK:- Get Keychain Value
    public func getKeychainValue(key: String) -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }

    //MARK:- Update Keychain Value
    public func updateKeychainValue(value: String, key: String) -> Bool {
        if let data = value.data(using: .utf8) {
            return KeychainWrapper.standard.update(data, forKey: key)
        }
        else{
            return false
        }
    }
    
    public func storeAccessTokenResponse(response:Landing.JWTToken.Response) -> Bool {
        var storedSuccessfully = false
        if let tokenResponseModel = response.viewModel {
            storedSuccessfully = storeResponse(accessTokenOptional:tokenResponseModel.accessToken, refreshTokenOptional: tokenResponseModel.refreshToken, expiresInOptional:tokenResponseModel.expiresIn, refreshLifeOptional:tokenResponseModel.refreshLife)
        }
        
        return storedSuccessfully
    }
    
    func storeResponse(accessTokenOptional:String?, refreshTokenOptional:String?, expiresInOptional:Int?, refreshLifeOptional:Int?) -> Bool {
        var storedSuccessfully = false
        
        if let accessToken = accessTokenOptional {
            storedSuccessfully = setTokenValue(accessToken, key: Constants.kAccessTokenKey)
            
            if storedSuccessfully {
                storedSuccessfully = setTokenValue(refreshTokenOptional!, key: Constants.kRefreshTokenKey)
                
                if storedSuccessfully {
                    let expiresIn:Int = expiresInOptional!
                    let refreshLife:Int = refreshLifeOptional!
                    
                    let expiresInDate:Date = Date().adding(.minute, value: expiresIn)
                    let refreshLifeDate:Date = Date().adding(.hour, value: refreshLife)
                    
                    UserDefaults.standard.set(expiresInDate, forKey: Constants.kAccessTokenExpiryKey)
                    UserDefaults.standard.set(refreshLifeDate, forKey: Constants.kRefreshTokenLifeKey)
                }
            }
        }
        
        return storedSuccessfully
    }
}
