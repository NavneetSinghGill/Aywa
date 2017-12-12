//
//  RequestManager.swift
//  SaitamaCycles
//
//  Created by Zoeb on 05/06/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class RequestManager: NSObject {
    
    //MARK: JWTToken API
    
    func fetchJWTToken(request:Landing.JWTToken.Request, completion:@escaping CompletionHandler){
        if ApplicationDelegate.isNetworkAvailable(){
            RealAPI().postObject(request:request.baseRequest(), completion:completion)
        }
        else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
}
