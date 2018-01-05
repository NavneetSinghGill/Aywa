//
//  MyListInteractor.swift
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

protocol MyListBusinessLogic
{
  func doSomething(request: MyList.Something.Request)
}

protocol MyListDataStore
{
  //var name: String { get set }
}

class MyListInteractor: MyListBusinessLogic, MyListDataStore
{
  var presenter: MyListPresentationLogic?
  var worker: MyListWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: MyList.Something.Request)
  {
    worker = MyListWorker()
    worker?.doSomeWork()
    
    let response = MyList.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
