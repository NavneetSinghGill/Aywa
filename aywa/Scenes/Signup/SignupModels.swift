//
//  SignupModels.swift
//  aywa
//
//  Created by Zoeb on 16/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

let registrationURL = "/registration"
let registerFacebookURL = "/registration/facebook"

enum Signup
{
  // MARK: Use cases
  
  enum Register
  {
    struct Request
    {
        var email :String?
        var password :String?
        //var confirmPassword :String?
        var name :String?
        var deviceIdentifier:String?
        var deviceType :Int?
        var birthday :Date?
        var ageGroup :String?
        var gender :String?
        var country :String?
        var countryName :String?
        var phone :String?
        var ipAddress :String?
        
        func baseRequest() -> BaseRequest {
            
            let baseRequest = BaseRequest()
            baseRequest.urlPath = registrationURL
            baseRequest.parameters[Constants.kEmailKey] = email
            baseRequest.parameters[Constants.kPasswordKey] = password
            //baseRequest.parameters[Constants.kConfirmPassword] = confirmPassword
            baseRequest.parameters[Constants.kNameKey] = name
            baseRequest.parameters[Constants.deviceIdentifier] = deviceIdentifier
            baseRequest.parameters[Constants.DeviceTypeKey] = deviceType
            baseRequest.parameters[Constants.kBirthdayKey] = birthday
            baseRequest.parameters[Constants.kAgeGroupKey] = ageGroup
            baseRequest.parameters[Constants.kGenderKey] = gender
            baseRequest.parameters[Constants.kCountryKey] = country
            baseRequest.parameters[Constants.kCountryNameKey] = countryName
            baseRequest.parameters[Constants.kPhoneKey] = phone
            baseRequest.parameters[Constants.kIPAddressKey] = ipAddress //TODO: need R&D on this
            return baseRequest
        }
    }
  
    struct RegisterFacebookRequest {
        var token : String?
        var email : String?
        
        var deviceIdentifier:String?
        var deviceType :Int?
        
        func baseRequest() -> BaseRequest {
            let baseRequest = BaseRequest()
            baseRequest.urlPath = registerFacebookURL
            baseRequest.parameters[Constants.kFbToken] = token
            baseRequest.parameters[Constants.kEmailKey] = email
            baseRequest.parameters[Constants.deviceIdentifier] = deviceIdentifier
            baseRequest.parameters[Constants.DeviceTypeKey] = deviceType
            return baseRequest
        }
    }
  }
}
