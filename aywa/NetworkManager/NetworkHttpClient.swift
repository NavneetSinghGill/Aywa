//
//  NetworkHttpClient.swift
//  SaitamaCycles
//
//  Created by Zoeb on 31/05/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper



class NetworkHttpClient: NSObject {
    
    typealias successBlock = (_ response: Any?) -> Void
    typealias failureBlock = (_ response: Any?) -> Void
    
    static let sharedInstance = NetworkHttpClient()
    
    var urlPathSubstring: String = ""
    
    override init() {
        let appSettings: AppSettings = AppSettingsManager.sharedInstance.fetchSettings()
        urlPathSubstring = appSettings.URLPathSubstring
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: BASE URL
    class func baseUrl() -> String {
        let appSettings: AppSettings = AppSettingsManager.sharedInstance.appSettings
        
        let secureConnection: String = appSettings.EnableSecureConnection ? Constants.SecureProtocol : Constants.InsecureProtocol
        if appSettings.NetworkMode == Constants.LiveEnviroment { // for live env
            return String.init(format: "%@%@", secureConnection, appSettings.ProductionURL)
        } else if appSettings.NetworkMode == Constants.StagingEnviroment { // for staging env
            return String.init(format: "%@%@", secureConnection, appSettings.StagingURL)
        } else // for local env
        {
            return String.init(format: "%@%@", secureConnection, appSettings.LocalURL)
        }
    }
    
    // MARK: API calls
    func getAPICall<T:Mappable>(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, genericResponse:T.Type, success:@escaping successBlock, failure:@escaping failureBlock) {
        performAPICall(strURL, methodType: .get, parameters: parameters, requestHeaders: headers, genericResponse: genericResponse, success: success, failure: failure)
    }
    
    func putAPICall<T:Mappable>(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, genericResponse:T.Type, success:@escaping successBlock, failure:@escaping failureBlock) {
        performAPICall(strURL, methodType: .put, parameters: parameters, requestHeaders: headers, genericResponse: genericResponse, success: success, failure: failure)
    }
    
    func postAPICall<T:Mappable>(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, genericResponse:T.Type, success:@escaping successBlock, failure:@escaping failureBlock) {
        performAPICall(strURL, methodType: .post, parameters: parameters, requestHeaders: headers, genericResponse:genericResponse, success: success, failure: failure)
    }
    
    func deleteAPICall<T:Mappable>(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, genericResponse:T.Type, success:@escaping successBlock, failure:@escaping failureBlock) {
        performAPICall(strURL, methodType: .delete, parameters: parameters, requestHeaders: headers, genericResponse: genericResponse, success: success, failure: failure)
    }
    
    func performAPICall<T:Mappable>(_ strURL : String, methodType: HTTPMethod, parameters : Dictionary<String, Any>?, requestHeaders : [String : String]?, genericResponse:T.Type, success:@escaping successBlock, failure:@escaping failureBlock){
        let completeURL:String = NetworkHttpClient.baseUrl() + BaseRequest.getUrl(path: strURL)
        var headers = requestHeaders
        if headers == nil {
            headers = NetworkHttpClient.getHeader() as? HTTPHeaders
        }
        if parameters?[BaseRequest.hasArrayResponse] != nil {
            var params:Dictionary<String, Any> = parameters!
            params[BaseRequest.hasArrayResponse] = nil
            
            Alamofire.request(completeURL, method: methodType, parameters: params, encoding: (methodType == .get ? URLEncoding.default : JSONEncoding.default), headers: headers).responseArray { (response: DataResponse<[T]>) in
                
                switch response.result {
                case .success(let value):
                    print(value)
                    success(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure(response)
                }
            }
        }
        else if parameters?[BaseRequest.hasNullResponse] != nil {
            
            var params:Dictionary<String, Any> = parameters!
            params[BaseRequest.hasArrayResponse] = nil
            Alamofire.request(completeURL, method: methodType, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { (response) -> Void in
                switch response.result {
                case .success(let value):
                    print(value)
                    success(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure(response)
                }
//                if response.result.isSuccess {
//                    print(responseObject.result)
//                    //                let resJson = JSON(response.result.value!)
//                    success(responseObject)
//                }
//                if response.result.isFailure {
//                    //                let error : Error = response.result.error!
//                    failure(responseObject)
//                }
            }
        }
        else
        {
            Alamofire.request(completeURL, method: methodType, parameters: parameters, encoding: (methodType == .get ? URLEncoding.default : JSONEncoding.default), headers: headers).responseObject { (response: DataResponse<T>) in
                
                switch response.result {
                case .success(let value):
                    print(value)
                    success(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    failure(response)
                }
            }
        }
        
    }
    
    func multipartPostAPICall(_ strURL: String, parameters: Dictionary<String, Any>?, data: Data, name: String, fileName: String, mimeType: String, success: @escaping successBlock, failure: @escaping failureBlock) -> Void{
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(data, withName: name, fileName: fileName, mimeType: mimeType)
        }, to: strURL, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    success(response)
                }
            case .failure(let encodingError):
                failure(encodingError)
            }
        })
    }
    
    class func getHeader() -> Dictionary<String, Any> {
        var header: HTTPHeaders = [String : String]()
        if let accessToken = SecurityStorageWorker().getKeychainValue(key: Constants.kAccessTokenKey) {
            header[Constants.kAuthorizationkey] = Constants.kBearerkey + accessToken
            header[Constants.kContentTypeKey] = Constants.kContentTypeValue
            header[Constants.kOriginKey] = Constants.kOriginValue
            print("Header: \(header)")
        }
        return header
    }
}


/*
 Alamofire.request(completeURL, method: methodType, parameters: parameters, encoding: (methodType == .get ? URLEncoding.default : JSONEncoding.default), headers: headers).responseJSON { response in
 
 switch response.result {
 case .success(let value):
 print(value)
 success(response)
 case .failure(let error):
 print(error.localizedDescription)
 failure(response)
 }
 
 }
 */

