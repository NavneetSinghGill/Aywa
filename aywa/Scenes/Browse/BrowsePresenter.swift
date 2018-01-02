//
//  BrowsePresenter.swift
//  aywa
//
//  Created by Bestpeers on 02/01/18.
//  Copyright (c) 2018 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol BrowsePresentationLogic
{
  func presentSomething(response: Browse.Something.Response)
}

class BrowsePresenter: BrowsePresentationLogic
{
  weak var viewController: BrowseDisplayLogic?
  
  // MARK: Do Browse Presenter
  
  func presentSomething(response: Browse.Something.Response)
  {
    let viewModel = Browse.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
