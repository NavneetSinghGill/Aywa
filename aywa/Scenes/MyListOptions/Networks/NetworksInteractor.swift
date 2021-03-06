//
//  NetworksInteractor.swift
//  aywa
//
//  Created by Bestpeers on 09/01/18.
//  Copyright (c) 2018 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NetworksBusinessLogic
{
  func doSomething(request: Networks.MyListNetworks.Request)
}

protocol NetworksDataStore
{
  //var name: String { get set }
}

class NetworksInteractor: NetworksBusinessLogic, NetworksDataStore
{
  var presenter: NetworksPresentationLogic?
  var worker: NetworksWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Networks.MyListNetworks.Request)
  {
    worker = NetworksWorker()
    worker?.doSomeWork()
//    
//    let response = Networks.MyListShows.Response()
//    presenter?.presentSomething(response: response)
  }
}
