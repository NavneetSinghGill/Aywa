//
//  MoviesViewController.swift
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

protocol MoviesDisplayLogic: class
{
  func displaySomething(viewModel: Movies.Something.ViewModel)
}

class MoviesViewController: UIViewController, MoviesDisplayLogic
{
  var interactor: MoviesBusinessLogic?
  var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?

     var indexOfCell: Int?
    
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
    let interactor = MoviesInteractor()
    let presenter = MoviesPresenter()
    let router = MoviesRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
    func initialiseView() {
        // Initialization code
        let nib = UINib(nibName: Identifiers.homeImageVerticalCollectionViewCell, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
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
    initialiseView()
  }
  
  // MARK: Do Movies ViewController
  
    @IBOutlet weak var collectionView: UICollectionView!
  
    func doSomething()
  {
    let request = Movies.Something.Request()
    interactor?.doSomething(request: request)
  }
  
  func displaySomething(viewModel: Movies.Something.ViewModel)
  {
    //nameTextField.text = viewModel.name
  }
}

extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
    
    func setCollectionView(forRow row: Int, sectionData: Home.Section.Response) {
        indexOfCell = row
        collectionView.tag = row
        self.collectionView.reloadData()
    }
    
    //MARK:- CollectionView Delegate And Datasource Methods
    //MARK: Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  10 //(sectionData!.shows?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeImagesCollectionViewCell
        print(indexPath.row)
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell, for: indexPath) as! HomeImagesCollectionViewCell
        cell.cellAlignment = .Vertical
       // cell.setUICollectionViewCell(forRow: indexOfCell! , show: (self.sectionData?.shows![indexPath.item])!)
        cell.contentView.layer.borderWidth = 1 
       return cell
    }
    
    //MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.frame.size.width - 6)/2
        
        return CGSize(width: width, height: width/Constants.generalVerticalCellAspectRatio)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}