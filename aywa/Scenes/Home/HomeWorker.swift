//
//  HomeWorker.swift
//  aywa
//
//  Created by Bestpeers on 19/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
typealias homeSectionResponseHandler = (_ response:Home.Section.Response) ->()

class HomeWorker
{
    func homeSection(request:Home.Section.Request, success:@escaping(homeSectionResponseHandler), fail:@escaping(homeSectionResponseHandler))
    {
        //call network etc.
        let manager = RequestManager()
        manager.fetchSliderBanner(request: request.baseRequest()) { (status, response) in
            self.handleSectionResponse(success: success, fail: fail, status: status, response: response)

        }
    }
    
    func handleSectionResponse(success:@escaping(homeSectionResponseHandler), fail:@escaping(homeSectionResponseHandler), status: Bool, response: Any?) {
        var message:String = Constants.kErrorMessage
        if status {
            if let result = response as? Home.Section.Response {
                success(result)
                return
            }
        }
        else {
            if let result = response as? Home.Section.Response {
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
        fail(Home.Section.Response(message: message)!)
    }
}
