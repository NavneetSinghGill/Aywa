//
//  HomeInteractor.swift
//  aywa
//
//  Created by Zoeb on 19/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeBusinessLogic
{
    func doSectionAPI(request: Home.Section.Request)
}

protocol HomeDataStore
{
  //var name: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
    
  var presenter: HomePresentationLogic?
  var worker: HomeWorker?
  
  // MARK: Do Home Interactor
    
    func doSectionAPI(request: Home.Section.Request) {
        worker = HomeWorker()
        worker?.homeSection(request: request, success: { (response) in
            print(response)
            self.presenter?.presentNextScreen(response:response)
            
        }, fail: { (response) in
            self.presenter?.presentError(response: response)
        })
    }
}
