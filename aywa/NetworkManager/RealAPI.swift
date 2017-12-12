//
//  RealAPI.swift
//  SaitamaCycles
//
//  Created by Zoeb on 01/06/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import Alamofire

class RealAPI: NSObject {
    
    var VMRequest: BaseRequest = BaseRequest()
    var isForbiddenRetry: Bool = false
    var realAPIBlock: CompletionHandler = { _,_ in }
    
    func putObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        interactAPIWithPutObject(request: request, completion: completion)
    }
    
    func getObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        interactAPIWithGetObject(request: request, completion: completion)
    }
    
    func postObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        interactAPIWithPostObject(request: request, completion: completion)
    }
    
    func deleteObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        interactAPIWithDeleteObject(request: request, completion: completion)
    }
    
    func multiPartObjectPost(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        interactAPIWithMultipartObjectPost(request: request, completion: completion)
    }
    
    // MARK: Request methods
    func interactAPIWithGetObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        initialSetup(request: request, requestType: Constants.RequestType.GET.rawValue)
        NetworkHttpClient.sharedInstance.getAPICall(request.urlPath, parameters: request.getParams(), success: { (responseObject) in
            self.handleSuccessResponse(response: responseObject, block: completion)
        }, failure: { (responseObject) in
            self.handleError(response: responseObject, block: completion)
        })
    }
    
    func interactAPIWithPutObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        initialSetup(request: request, requestType: Constants.RequestType.PUT.rawValue)
        NetworkHttpClient.sharedInstance.putAPICall(request.urlPath, parameters: request.getParams(), headers: request.headers, success: { (responseObject) in
            self.handleSuccessResponse(response: responseObject, block: completion)
        }, failure: { (responseObject) in
            self.handleError(response: responseObject, block: completion)
        })
    }
    
    func interactAPIWithPostObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        initialSetup(request: request, requestType: Constants.RequestType.POST.rawValue)
        NetworkHttpClient.sharedInstance.postAPICall(request.urlPath, parameters: request.getParams(), headers: request.headers, success: { (responseObject) in
            self.handleSuccessResponse(response: responseObject, block: completion)
        }, failure: { (responseObject) in
            self.handleError(response: responseObject, block: completion)
        })
    }
    
    func interactAPIWithDeleteObject(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        initialSetup(request: request, requestType: Constants.RequestType.DELETE.rawValue)
        NetworkHttpClient.sharedInstance.deleteAPICall(request.urlPath, parameters: request.getParams(), headers: request.headers, success: { (responseObject) in
            self.handleSuccessResponse(response: responseObject, block: completion)
        }, failure: { (responseObject) in
            self.handleError(response: responseObject, block: completion)
        })
    }
    
    func interactAPIWithMultipartObjectPost(request: BaseRequest, completion: @escaping CompletionHandler) -> Void {
        initialSetup(request: request, requestType: Constants.RequestType.MultiPartPost.rawValue)
        NetworkHttpClient.sharedInstance.multipartPostAPICall(request.urlPath, parameters: request.getParams(), data: request.fileData, name: request.dataFilename, fileName: request.fileName, mimeType: request.mimeType, success: { (responseObject) in
            self.handleSuccessResponse(response: responseObject, block: completion)
        }, failure: { (responseObject) in
            self.handleError(response: responseObject, block: completion)
        })
    }
    
    //Handling success response
    func handleSuccessResponse(response: Any?, block:@escaping CompletionHandler) -> Void {
        
        let responseStatus = (response as! DataResponse<Any>).response
        let message: String = String.init(format: "Success:- URL:%@\n", (responseStatus?.url?.absoluteString)!)
        print(message)
        
        if responseStatus?.statusCode == Constants.ResponseStatusSuccess || responseStatus?.statusCode == Constants.ResponseStatusCreated {
            if response != nil {
                isForbiddenRetry = false
                if let result = (response as! DataResponse<Any>).result.value {
                    let JSON = result as! NSDictionary
                    print(JSON)
                    block(true, JSON)
                }
                return
            }
        }
        else if self.isForbiddenResponse(statusCode: (responseStatus?.statusCode)) {
            realAPIBlock = block
            renewLogin()
            return
        }
        else{
            if response != nil {
                if let result = (response as! DataResponse<Any>).result.value {
                    if let JSON = result as? NSDictionary {
                        print(JSON)
                        block(false, JSON)
                        return
                    }
                }
            }
        }
        
        block(false, nil)
    }
    
    //Handling Error response
    func handleError(response: Any?, block: @escaping CompletionHandler) -> Void {
        if let responseStatus = (response as! DataResponse<Any>).response{
           
            if self.isForbiddenResponse(statusCode: (responseStatus.statusCode)) {
                realAPIBlock = block
                renewLogin()
                return
            }
        }
        
        var errorResponse: Any?
        
        let error : Error? = (response as! DataResponse<Any>).result.error!
        
        let detailedError: NSError = error! as NSError
        if detailedError.localizedRecoverySuggestion != nil {
            do {
                errorResponse = try JSONSerialization.jsonObject(with: (detailedError.localizedRecoverySuggestion?.data(using: String.Encoding.utf8))!, options: JSONSerialization.ReadingOptions.mutableContainers)
                errorResponse != nil ? block(false, errorResponse) : block(false, error)
            }
            catch _ {
                // Error handling
            }
        }
        else {
            block(false, detailedError.description)
        }
    }
    
    func initialSetup(request: BaseRequest, requestType: NSInteger) -> Void {
        VMRequest = request
        VMRequest.requestType = requestType
        let message: String = String.init(format: "Info: Performing API call with [URL:%@] [params: %@]", request.urlPath, request.getParams())
        print(message)
    }
    
    func isForbiddenResponse(statusCode: NSInteger?) -> Bool {
        if statusCode != nil && statusCode == Constants.ResponseStatusForbidden && isForbiddenRetry == false {
            isForbiddenRetry = true
            return true
        }
        else if statusCode != nil && statusCode == Constants.ResponseStatusForbidden && isForbiddenRetry == true {
//            ApplicationDelegate.performLogout()
        }
        return false
    }
    
    func renewLogin() -> Void {
        // login with saved values
        self.loginWithSavedValues()
    }
    
    func loginWithSavedValues() {}
    
    func getLoginDetails() -> (email:String?, password:String?) {
        
//        guard let username = UserDefaults.standard.value(forKey: Constants.kUsernameKey) as? String else {
//            return (nil, nil)
//        }
        
//        do {
//            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
//                                                    account: username,
//                                                    accessGroup: KeychainConfiguration.accessGroup)
//            let keychainPassword = try passwordItem.readPassword()
//            return (username, keychainPassword)
//        }
//        catch {
//            fatalError("Error reading password from keychain - \(error)")
//        }
        
        return (nil, nil)
    }
    
    func renewLoginRequestCompleted() {
        // calling failed API again
        switch VMRequest.requestType {
        case Constants.RequestType.GET.rawValue:
            self.interactAPIWithGetObject(request: VMRequest, completion: realAPIBlock)
            break
        case Constants.RequestType.POST.rawValue:
            self.interactAPIWithPostObject(request: VMRequest, completion: realAPIBlock)
            break
        case Constants.RequestType.PUT.rawValue:
            self.interactAPIWithPutObject(request: VMRequest, completion: realAPIBlock)
            break
        case Constants.RequestType.MultiPartPost.rawValue:
            self.interactAPIWithMultipartObjectPost(request: VMRequest, completion: realAPIBlock)
            break
        case Constants.RequestType.DELETE.rawValue:
            self.interactAPIWithDeleteObject(request: VMRequest, completion: realAPIBlock)
            break
        default:
            break
        }
    }
}
