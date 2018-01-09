//
//  MyListViewController.swift
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

protocol MyListDisplayLogic: class
{
  func displaySomething(viewModel: MyList.Something.ViewModel)
}

class MyListViewController: UIViewController, MyListDisplayLogic
{
  var interactor: MyListBusinessLogic?
  var router: (NSObjectProtocol & MyListRoutingLogic & MyListDataPassing)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = MyListInteractor()
    let presenter = MyListPresenter()
    let router = MyListRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
   private func initialiseView() {
    navigationBarWithLeftSideTitle(isTitle: false, titleName: "My List")
    }
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    doSomething()
  }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func doSomething()
  {
    let request = MyList.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: MyList.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
