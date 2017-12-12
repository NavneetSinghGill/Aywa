//
//  LandingModels.swift
//  aywa
//
//  Created by Zoeb on 11/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Foundation
import ObjectMapper

let tokenURL = "/token"
let secret = "Secret"

enum Landing {
    // MARK: Use cases
    
    enum JWTToken
    {
        struct Request {
            
            func baseRequest() -> BaseRequest {
                
                let baseRequest = BaseRequest()
                baseRequest.urlPath = tokenURL
                baseRequest.parameters[Constants.kApiKey] = Constants.kApiKeyValue
                baseRequest.parameters[secret] = Constants.kApiKeyValue
                baseRequest.parameters[Constants.deviceIdentifier] = UserDefaults.standard.string(forKey: Constants.deviceIdentifier) ?? (UIDevice.current.identifierForVendor?.uuidString)!
                return baseRequest
            }
        }
        struct Response: Mappable {
            
            // MARK: Declaration for string constants to be used to decode and also serialize.
            private struct SerializationKeys {
                static let expiresIn = "ExpiresIn"
                static let refreshLife = "RefreshLife"
                static let refreshToken = "RefreshToken"
                static let accessToken = "AccessToken"
                static let message = "Message"
            }
            
            // MARK: Properties
            public var viewModel: ViewModel?
            public var message: String?
            
            // MARK: ObjectMapper Initializers
            /// Map a JSON object to this class using ObjectMapper.
            ///
            /// - parameter map: A mapping from ObjectMapper.
            public init?(map: Map){
                self.viewModel = ViewModel()
            }
            
            public init?(message: String){
               self.message = message
            }
            
            /// Map a JSON object to this class using ObjectMapper.
            ///
            /// - parameter map: A mapping from ObjectMapper.
            public mutating func mapping(map: Map) {
                self.viewModel!.expiresIn <- map[SerializationKeys.expiresIn]
                self.viewModel!.refreshLife <- map[SerializationKeys.refreshLife]
                self.viewModel!.refreshToken <- map[SerializationKeys.refreshToken]
                self.viewModel!.accessToken <- map[SerializationKeys.accessToken]
                message <- map[SerializationKeys.message]
            }
            
            /// Generates description of the object in the form of a NSDictionary.
            ///
            /// - returns: A Key value pair containing all valid values in the object.
            public func dictionaryRepresentation() -> [String: Any] {
                var dictionary: [String: Any] = [:]
                if let value = self.viewModel!.expiresIn { dictionary[SerializationKeys.expiresIn] = value }
                if let value = self.viewModel!.refreshLife { dictionary[SerializationKeys.refreshLife] = value }
                if let value = self.viewModel!.refreshToken { dictionary[SerializationKeys.refreshToken] = value }
                if let value = self.viewModel!.accessToken { dictionary[SerializationKeys.accessToken] = value }
                if let value = message { dictionary[SerializationKeys.message] = value }
                return dictionary
            }
            
        }
        struct ViewModel {
            
            // MARK: Properties
            public var expiresIn: Int?
            public var refreshLife: Int?
            public var refreshToken: String?
            public var accessToken: String?
        }
    }
}
