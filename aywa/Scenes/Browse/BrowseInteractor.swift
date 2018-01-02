//
//  BrowseInteractor.swift
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

protocol BrowseBusinessLogic
{
  func doSomething(request: Browse.Something.Request)
}

protocol BrowseDataStore
{
  //var name: String { get set }
}

class BrowseInteractor: BrowseBusinessLogic, BrowseDataStore
{
  var presenter: BrowsePresentationLogic?
  var worker: BrowseWorker?
  //var name: String = ""
  
  // MARK: Do Browse DataStore
  
  func doSomething(request: Browse.Something.Request)
  {
    worker = BrowseWorker()
    worker?.doSomeWork()
    
    let response = Browse.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
