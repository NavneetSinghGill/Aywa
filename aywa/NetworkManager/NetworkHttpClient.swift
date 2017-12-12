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
    //TODO: need to pass generic parameter to handle response type
    func getAPICall(_ strURL : String, parameters : Dictionary<String, Any>?, success:@escaping successBlock, failure:@escaping failureBlock) {
        //performAPICall(response: response,strURL, methodType: .get, parameters: parameters, requestHeaders: nil, success: success, failure: failure)
    }
    
    func putAPICall(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, success:@escaping successBlock, failure:@escaping failureBlock) {
        //performAPICall(response: response,strURL, methodType: .put, parameters: parameters, requestHeaders: headers, success: success, failure: failure)
    }
    
    func postAPICall(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, success:@escaping successBlock, failure:@escaping failureBlock) {
        //performAPICall(response: response,strURL, methodType: .post, parameters: parameters, requestHeaders: headers, success: success, failure: failure)
    }
    
    func deleteAPICall(_ strURL : String, parameters : Dictionary<String, Any>?, headers : [String : String]?, success:@escaping successBlock, failure:@escaping failureBlock) {
        //performAPICall(response: response, strURL, methodType: .delete, parameters: parameters, requestHeaders: headers, success: success, failure: failure)
    }
    
    func performAPICall<T: Mappable>(response: T, _ strURL : String, methodType: HTTPMethod, parameters : Dictionary<String, Any>?, requestHeaders : [String : String]?, success:@escaping successBlock, failure:@escaping failureBlock){
        let completeURL:String = NetworkHttpClient.baseUrl() + strURL
        var headers = requestHeaders
        if headers == nil {
            headers = NetworkHttpClient.getHeader() as? HTTPHeaders
        }

//        Alamofire.request(completeURL, method: methodType, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
//
//            if responseObject.result.isSuccess {
//                success(responseObject)
//            }
//            if responseObject.result.isFailure {
//                failure(responseObject)
//            }
//        }
        
        Alamofire.request(completeURL, method: methodType, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseObject { (response: DataResponse<T>) in
            
            let authResponse = response.result.value
            print(authResponse ?? "fail....")
            if response.result.isSuccess {
                success(response)
            }
            if response.result.isFailure {
                failure(response)
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
        if UserDefaults.standard.value(forKey: Constants.kSessionKey) != nil {
            header[Constants.kSessionKey] = "Bearer " + (UserDefaults.standard.value(forKey: Constants.kSessionKey) as! String)
        }
        print("Header: \(header)")
        return header
    }
}
