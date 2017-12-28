//
//  HomeSliderBannerWorker.swift
//  aywa
//
//  Created by Zoeb on 20/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

typealias sliderBannerResponseHandler = (_ response:HomeSliderBanner.SliderBanner.Response) ->()

class HomeSliderBannerWorker
{
    func sliderBanner(request:HomeSliderBanner.SliderBanner.Request, success:@escaping(sliderBannerResponseHandler), fail:@escaping(sliderBannerResponseHandler))
    {
        //call network etc.
        let manager = RequestManager()
        manager.fetchSliderBanner(request: request.baseRequest()) { (status, response) in
            self.handleSlideBannerResponse(success: success, fail: fail, status: status, response: response)
            
        }
    }
    
    func handleSlideBannerResponse(success:@escaping(sliderBannerResponseHandler), fail:@escaping(sliderBannerResponseHandler), status: Bool, response: Any?) {
        var message:String = Constants.kErrorMessage
        if status {
            if let result = response as? HomeSliderBanner.SliderBanner.Response {
                success(result)
                return
            }
        }
        else {
            if let result = response as? HomeSliderBanner.SliderBanner.Response {
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
        fail(HomeSliderBanner.SliderBanner.Response(message: message)!)
    }
}
