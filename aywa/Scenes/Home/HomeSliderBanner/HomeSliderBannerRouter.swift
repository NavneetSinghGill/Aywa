//
//  HomeSliderBannerRouter.swift
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

@objc protocol HomeSliderBannerRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HomeSliderBannerDataPassing
{
  var dataStore: HomeSliderBannerDataStore? { get }
}

class HomeSliderBannerRouter: NSObject, HomeSliderBannerRoutingLogic, HomeSliderBannerDataPassing
{
  weak var viewController: HomeSliderBannerViewController?
  var dataStore: HomeSliderBannerDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: HomeSliderBannerViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: HomeSliderBannerDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
