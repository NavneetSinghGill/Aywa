




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
import SVProgressHUD

protocol MoviesDisplayLogic: class
{
    func displayMyListMoviesError(response: Movies.MyListMovies.Response)
    func displayMyListMoviesResponse(response: [Movies.MyListMovies.Response])
}

class MoviesViewController: UIViewController, MoviesDisplayLogic
{
    var interactor: MoviesBusinessLogic?
    var router: (NSObjectProtocol & MoviesRoutingLogic & MoviesDataPassing)?
    let numberOfCollectionViewCellsInSingleLine:CGFloat = isiPad ? 3 : 2
    let collectionViewCellSpacing:CGFloat = 6 // Used in cell size calculation
    
    var moviesArray = [Movies.MyListMovies.Response]()
    var homeSectionArray : Home.Section.Response?
    var setTitle: String = ""
    
    
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
    //MARK:- Private Methods
    //For Hide And Show Collection View , label and Button
    func showCollectionView() {
        if moviesArray.isEmpty && homeSectionArray == nil  {
            self.collectionView.isHidden = true
            self.labelForAddMovies.isHidden = false
            self.buttonForAddMovies.isHidden = false
        }
        else {
            self.collectionView.dataSource = self
            self.collectionView.delegate = self
            self.collectionView.isHidden = false
            self.labelForAddMovies.isHidden = true
            self.buttonForAddMovies.isHidden = true
            
            self.collectionView.reloadData()
        }
    }
    func initialiseView() {
        
        let nib = UINib(nibName: Identifiers.homeImageVerticalCollectionViewCell, bundle: Bundle.main)
        collectionView.register(nib, forCellWithReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell)
        self.collectionView.isHidden = true
        self.labelForAddMovies.isHidden = true
        self.buttonForAddMovies.isHidden = true
        if setTitle.isEmpty {
            navigationBarWithLeftSideTitle(isTitle: false, titleName: LocaleKeys.kMoviesString)
            // Call Movies API Request
            doMoviesRequest()
        }else{
            navigationBarWithLeftSideTitle(isTitle: false, titleName: setTitle)
            showCollectionView()
        }
        
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
        //showCollectionView()
        initialiseView()
    }
    
    // MARK: Do Movies ViewController
    
    @IBOutlet weak var labelForAddMovies: UILabel!
    
    @IBOutlet weak var buttonForAddMovies: UIButton!//TODO: User interactions Enable
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK:- Request For Movies
    func doMoviesRequest()
    {
        SVProgressHUD.show()
        let request = Movies.MyListMovies.Request()
        interactor?.doMovies(request: request)
    }
    
    func displayMyListMoviesError(response: Movies.MyListMovies.Response){
        SVProgressHUD.dismiss()
        print("Movies Error:\(response)")
        showCollectionView()
    }
    func displayMyListMoviesResponse(response: [Movies.MyListMovies.Response]){
        SVProgressHUD.dismiss()
        // print("Movies Response:\(response.count)")
        moviesArray = response
        showCollectionView()
    }
    
}

extension MoviesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
    
    //MARK:- CollectionView Delegate And Datasource Methods
    //MARK: Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if homeSectionArray != nil{
            return (homeSectionArray?.shows?.count)!
        }
        else{
             return moviesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeImagesCollectionViewCell
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell, for: indexPath) as! HomeImagesCollectionViewCell
        cell.cellAlignment = .Vertical
        if homeSectionArray != nil {
            cell.setUICollectionViewCell(forRow: indexPath.row, show: (homeSectionArray?.shows![indexPath.row])!)
        }
        else{
        cell.setUICollectionViewCellForMovies( shows: self.moviesArray[indexPath.item])
        }
        return cell
    }
    
    //MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.collectionView.frame.size.width - (self.numberOfCollectionViewCellsInSingleLine - 1) * self.collectionViewCellSpacing) / self.numberOfCollectionViewCellsInSingleLine
        
        return CGSize(width: width, height: width/Constants.generalVerticalCellAspectRatio)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view  selected index path \(indexPath.row)")
    }
}
