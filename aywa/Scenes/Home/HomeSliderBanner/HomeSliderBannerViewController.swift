//
//  HomeSliderBannerViewController.swift
//  aywa
//
//  Created by Bestpeers on 20/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeSliderBannerDisplayLogic: class
{
    func displayError(response: HomeSliderBanner.SliderBanner.Response)
    func displayHomeScreen(response: HomeSliderBanner.SliderBanner.Response)
}

class HomeSliderBannerViewController: UIViewController, HomeSliderBannerDisplayLogic
{
    var interactor: HomeSliderBannerBusinessLogic?
    var router: (NSObjectProtocol & HomeSliderBannerRoutingLogic & HomeSliderBannerDataPassing)?
    
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
        let interactor = HomeSliderBannerInteractor()
        let presenter = HomeSliderBannerPresenter()
        let router = HomeSliderBannerRouter()
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
        // Call Slider Banner API
        doCallSliderBannerAPI()
        let nib = UINib(nibName: Identifiers.homeAdvertCollectionCell, bundle: Bundle.main)
        homeHeaderCollectionView.register(nib, forCellWithReuseIdentifier: Identifiers.homeAdvertCollectionCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // MARK: Do something
    
    var sliderBannarArray = [HomeSliderBanner.SliderBanner.Banners]()
    
    @IBOutlet weak var homeHeaderCollectionView: UICollectionView!
    
    @IBAction func tvShareButtonTapped(_ sender: Any) {
        doTVShareAction()
    }
    @IBAction func menuButtonTapped(_ sender: Any) {
        doMenuAction()
    }
    
    
    //MARK: Do TV Share Action
    func doTVShareAction() {
        print("Perform TV Share Action")
    }
    //MARK: Do Menu Action
    func doMenuAction() {
        print("Perform Menu Action")
    }
    
    func displayError(response: HomeSliderBanner.SliderBanner.Response)
    {
        print("Error occured: \(response)")
    }
    
    func displayHomeScreen(response: HomeSliderBanner.SliderBanner.Response)
    {
        print("Show Home Screen Data!!!:\(String(describing: response.banners)) ")
        sliderBannarArray = (response.banners)!
        
        //        sliderBannarArray = sliderBannarArray.sorted{ ($0 as! HomeSliderBanner.SliderBanner.Banners).displayOrder! < ($1 as! HomeSliderBanner.SliderBanner.Banners).displayOrder! }
        
        sliderBannarArray = sliderBannarArray.sorted{ ($0 ).displayOrder! < ($1 ).displayOrder! }
        
        print(sliderBannarArray)
        
        print(sliderBannarArray.count)
        print(response.banners![0].titleImage ?? String() )
        self.homeHeaderCollectionView.reloadData()
        
    }
    
    //MARK: For Call Slider Banner API
    func doCallSliderBannerAPI()  {
        let request = HomeSliderBanner.SliderBanner.Request()
        interactor?.doCallSliderBannerAPI(request: request)
    }
}

extension HomeSliderBannerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //MARK:- UICollectionView methods
    //MARK: Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sliderBannarArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeHeaderAdvertisementCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeAdvertCollectionCell, for: indexPath) as! HomeHeaderAdvertisementCollectionViewCell
        cell.setUIForSliderBanner(indexPathValueIs: indexPath.row, arrayOfValue: self.sliderBannarArray)
        return cell
    }
    
    //MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}