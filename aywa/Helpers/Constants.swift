//
//  Constants.swift
// WordPower
//
//  Created by Zoeb  on 11/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import Foundation
import UIKit

typealias CompletionHandler = (_ success: Bool, _ response: Any?) -> Void

struct Constants {

    // MARK: - General Constants
    static let DeviceTokenKey = "device_token"
    static let DeviceInfoKey = "device_info"
    static let DeviceTypeKey = "device_type"
    static let EmptyString = ""
    static let kErrorMessage = "Something went wrong while processing your request"
    static let kNoNetworkMessage = "No network available"
    
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
    static let ResponseStatusForbidden = 401
    
    // MARK: - Network Keys
    static let InsecureProtocol = "http://"
    static let SecureProtocol = "https://"
    static let LocalEnviroment = "LOCAL"
    static let StagingEnviroment = "STAGING"
    static let LiveEnviroment = "LIVE"
}

