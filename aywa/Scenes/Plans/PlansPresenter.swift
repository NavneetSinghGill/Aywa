//
//  PlansPresenter.swift
//  aywa
//
//  Created by Bestpeers on 18/01/18.
//  Copyright (c) 2018 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PlansPresentationLogic
{
  func presentSomething(response: Plans.Something.Response)
}

class PlansPresenter: PlansPresentationLogic
{
  weak var viewController: PlansDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Plans.Something.Response)
  {
    let viewModel = Plans.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}