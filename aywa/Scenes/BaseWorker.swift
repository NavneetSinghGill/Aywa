//
//  BaseWorker.swift
//  aywa
//
//  Created by Best Peers on 16/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class BaseWorker {
    
    public func handleTokenResponse(success:@escaping(refreshTokenResponseHandler), fail:@escaping(refreshTokenResponseHandler), status: Bool, response: Any?) {
        var message:String = Constants.kErrorMessage
        if status {
            if let result = response as? Landing.JWTToken.Response {
                success(result)
                return
            }
        }
        else {
            if let result = response as? Landing.JWTToken.Response {
                fail(result)
                return
            }
            else
            {
                if let result = response as? String {
                    message = result
                }
            }
        }
        fail(Landing.JWTToken.Response(message:message)!)
    }
}
