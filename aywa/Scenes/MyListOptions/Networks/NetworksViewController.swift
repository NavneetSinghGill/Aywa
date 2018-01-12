//
//  NetworksViewController.swift
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

protocol NetworksDisplayLogic: class
{
  func displaySomething(viewModel: Networks.MyListNetworks.ViewModel)
}

class NetworksViewController: UIViewController, NetworksDisplayLogic
{
  var interactor: NetworksBusinessLogic?
  var router: (NSObjectProtocol & NetworksRoutingLogic & NetworksDataPassing)?

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
    let interactor = NetworksInteractor()
    let presenter = NetworksPresenter()
    let router = NetworksRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
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
  }
  
  // MARK: Do Network ViewController
  
    @IBOutlet weak var labelForAddNetworks: UILabel!
    
    @IBOutlet weak var buttonForAddNetworks: UIButton!
    
    @IBAction func addButtonTapped(_ sender: Any) {
    }
  
    func doSomething()
  {
    let request = Networks.MyListNetworks.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: Networks.MyListNetworks.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}
