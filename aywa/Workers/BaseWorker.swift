//
//  BaseWorker.swift
//  aywa
//
//  Created by Zoeb on 16/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

typealias commonResponseHandler = (_ response:Common.Response) ->()

class BaseWorker {
    
    public func handleTokenResponse(success:@escaping(accessTokenResponseHandler), fail:@escaping(accessTokenResponseHandler), status: Bool, response: Any?) {
        var message:String = Constants.kErrorMessage
        if status {
            if let result = response as? Token.JWTToken.Response {
                success(result)
                return
            }
        }
        else {
            if let result = response as? Token.JWTToken.Response {
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
        fail(Token.JWTToken.Response(message:message)!)
    }
    
    public func handleCommonResponse(success:@escaping(commonResponseHandler), fail:@escaping(commonResponseHandler), status: Bool, response: Any?) {
        var message:String = Constants.kErrorMessage
        if status {
            success(Common.Response.init(message: "Success")!)
            return
        }
        else if let result = response as? String {
            message = result
        }
        fail(Common.Response(message:message)!)
    }
}
