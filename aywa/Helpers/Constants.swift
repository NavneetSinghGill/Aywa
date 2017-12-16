//
//  Constants.swift
// WordPower
//
//  Created by Zoeb  on 11/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import Foundation
import UIKit

let ApplicationDelegate = UIApplication.shared.delegate as! AppDelegate

typealias CompletionHandler = (_ success: Bool, _ response: Any?) -> Void

let isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

struct Constants {

    // MARK: - General Constants
    static let deviceIdentifier = "DeviceIdentifier"
    static let DeviceInfoKey = "device_info"
    static let DeviceTypeKey = "device_type"
    static let EmptyString = ""
    static let kErrorMessage = "Something went wrong while processing your request"
    static let kNoNetworkMessage = "No network available"
    static let kContentTypeKey = "Content-Type"
    static let kContentTypeValue = "application/json"
    static let kOriginKey = "Origin"
    static let kOriginValue = "www.aywa.com"
    static let kApiKey = "ApiKey"
    static let kApiKeyValue = "eX2DEXCjXbWVP54iehZmTq95NBS2B8zVyHUQHJNM52Q="
    
    static let kAccessTokenKey = "AccessToken"
    static let kAccessTokenExpiryKey = "AccessTokenExpiry"
    
    static let kRefreshTokenKey = "RefreshToken"
    static let kRefreshTokenLifeKey = "RefreshTokenLife"
    
    static let kAuthorizationkey = "Authorization"
    static let kBearerkey = "Bearer "
    
    // MARK: - User Defaults
    
    // MARK: - Enums
    enum RequestType: NSInteger {
        case GET
        case POST
        case MultiPartPost
        case DELETE
        case PUT
    }
    
    // MARK: - Numerical Constants
    static let StatusSuccess = 1
    static let ResponseStatusSuccess = 200
    static let ResponseStatusCreated = 201
    static let ResponseStatusAccepted = 202
    static let ResponseStatusForbidden = 403
    
    // MARK: - Network Keys
    static let InsecureProtocol = "http://"
    static let SecureProtocol = "https://"
    static let LocalEnviroment = "LOCAL"
    static let StagingEnviroment = "STAGING"
    static let LiveEnviroment = "LIVE"
}

