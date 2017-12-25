//
//  HomeSliderBannerPresenter.swift
//  aywa
//
//  Created by Bestpeers on 20/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeSliderBannerPresentationLogic
{
 // func presentSomething(response: HomeSliderBanner.Something.Response)
    func presentError(response: HomeSliderBanner.SliderBanner.Response)
    func presentNextScreen(response: HomeSliderBanner.SliderBanner.Response)
}

class HomeSliderBannerPresenter: HomeSliderBannerPresentationLogic
{
  weak var viewController: HomeSliderBannerDisplayLogic?
  
  // MARK: Do something
  
//  func presentSomething(response: HomeSliderBanner.Something.Response)
//  {
//    let viewModel = HomeSliderBanner.Something.ViewModel()
//    //viewController?.displaySomething(viewModel: viewModel)
//  }
    
    // MARK: Do Slider Banner
    
    
    func presentError(response: HomeSliderBanner.SliderBanner.Response)
    {
        viewController?.displayError(response: response)
    }
    
    func presentNextScreen(response: HomeSliderBanner.SliderBanner.Response)
    {
        viewController?.displayHomeScreen(response: response)
    }
}