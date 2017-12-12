//
//  Request.swift
//  SaitamaCycles
//
//  Created by Zoeb on 29/05/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import Alamofire

class BaseRequest: NSObject {

    var urlPath: String
    var requestType: NSInteger
    var fileData: Data
    var dataFilename: String
    var fileName: String
    var mimeType: String
    var headers: [String: String]?
    var parameters: Dictionary<String, Any>
    
    
    let authUrl = "users/"
    let paymentCreationUrl = "payments/"
    let placesUrl = "places/"
    
    override init() {
        urlPath = ""
        requestType = 0
        fileData = Data()
        dataFilename = ""
        fileName = ""
        mimeType = ""
        parameters = [:]
        super.init()
    }
    
    public func getParams() -> Dictionary<String, Any> {
        return parameters
    }
    
    public class func getUrl(path: String) -> String {
        let client: NetworkHttpClient = NetworkHttpClient.sharedInstance
        return String.init(format: "%@%@",client.urlPathSubstring, path)
    }
    
    func initwithAuthRequest(email:String, password:String) -> BaseRequest{
        parameters["email"] = email
        parameters["password"] = password
        urlPath = authUrl
        return self
    }
    
    func initwithPaymentListRequest() -> BaseRequest{
        urlPath = paymentCreationUrl
        return self
    }
    
    func initwithPlacesRequest() -> BaseRequest{
        urlPath = placesUrl
        return self
    }
}
