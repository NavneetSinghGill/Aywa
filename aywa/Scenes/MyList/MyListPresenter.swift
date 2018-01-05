//
//  MyListPresenter.swift
//  aywa
//
//  Created by Bestpeers on 05/01/18.
//  Copyright (c) 2018 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MyListPresentationLogic
{
  func presentSomething(response: MyList.Something.Response)
}

class MyListPresenter: MyListPresentationLogic
{
  weak var viewController: MyListDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: MyList.Something.Response)
  {
    let viewModel = MyList.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
