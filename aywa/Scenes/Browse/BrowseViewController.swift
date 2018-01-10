//
//  BrowseViewController.swift
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
import SVProgressHUD

protocol BrowseDisplayLogic: class
{
    func displayBrowseCatalogError(response: Browse.Catalogs.Response)
    func displayBrowserCatalogsResponse(response: Browse.Catalogs.Response)
    // For Section
    func displayHomeSectionError(response: Home.Section.Response)
    func displayHomeSectionResponse(response: [Home.Section.Response])
}

class BrowseViewController: UIViewController, BrowseDisplayLogic
{
    var interactor: BrowseBusinessLogic?
    var router: (NSObjectProtocol & BrowseRoutingLogic & BrowseDataPassing)?
    let cellHeight: CGFloat = 70
    
    static let movies = "Movies"
    static let tvShows = "TV Shows"
    static let networks = "Networks"
    static let genres = "Genres"
    
    static let displayOrderOne: Int = 1
    static let displayOrderSix: Int = 6
    
    //var browseArray = [movies, tvShows, networks]
    
    
    // Section 1 For Movies, TV Shows and Networks
    let sectionFirstArray = [movies, tvShows, networks]
    // Section 2 for Catalogs
    var sectionSecondArray = [String]()
    // Section 3 For Recently Add and New Releases
    var sectionThridArray = [String]()
    // Section 4 For Genres
    var sectionfourthArray = [genres]
    var browseSectionsItemsArray = [Array<Any>]()
    
    var browseSectionArray = [Home.Section.Response]()
    var browseDictionary: Dictionary =  [String : Any]()
    
    private let browseReuseIdentifier = "BrowseTableViewCell"
    
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
        let interactor = BrowseInteractor()
        let presenter = BrowsePresenter()
        let router = BrowseRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    //MARK: Initial Setup
    private func initialiseView() {
        navigationBarWithLeftSideTitle(isTitle: true, titleName: "  Browse")
        let browseNIB = UINib(nibName: Identifiers.browseTableViewCell, bundle: nil)
        tableView.register(browseNIB, forCellReuseIdentifier: Identifiers.browseTableViewCell)
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.clear
        
        browseSectionsItemsArray.append(sectionFirstArray)
        
        doCatalogsRequest()
        doBrowseSectionRequest()
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
    
    // MARK: Do Browse
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Do Catalogs request
    func doCatalogsRequest(){
        SVProgressHUD.show()
        let request = Browse.Catalogs.Request()
        interactor?.doCatalogs(request: request)
    }
    
    // Get Catalogs Response handle Protocal methods
    func displayBrowseCatalogError(response: Browse.Catalogs.Response){
        SVProgressHUD.dismiss()
        print("Show Catalogs Error Response!!!:\(String(describing: response)) ")
    }
    func displayBrowserCatalogsResponse(response: Browse.Catalogs.Response){
        SVProgressHUD.dismiss()
        for indexValue in 0..<(response.catalogs?.count ?? 0 ) {
            let nameString = response.catalogs![indexValue].name
            //browseArray.append(nameString!)
            sectionSecondArray.append(nameString!)
        }
        browseSectionsItemsArray.append(sectionSecondArray)
        //        print("Catalog List :\(sectionSecondArray)")
        // browseArray = browseArray.sorted(by: <) //TODO: Sorting
        self.tableView.reloadData()
    }
    
    // For Section API Request and Get Response
    func doBrowseSectionRequest()  {
        SVProgressHUD.show()
        let request = Home.Section.RequestForBrowseSection()
        interactor?.doSection(request: request)
    }
    func displayHomeSectionError(response: Home.Section.Response){
        SVProgressHUD.dismiss()
        print("Get Home Section Error Response !!! \(response)")
    }
    func displayHomeSectionResponse(response: [Home.Section.Response]){
        SVProgressHUD.dismiss()
        print("Get Home Section Success Response !!! \(response)")
        print(response.count)
        
        /*
         //        for intIndex in 0..<(response.count) {
         //            print(response[intIndex].displayOrder!)
         //            if response[intIndex].displayOrder == BrowseViewController.displayOrderOne || response[intIndex].displayOrder == BrowseViewController.displayOrderSix {
         //                browseArray.append(response[intIndex].name!)
         //            }
         //        }
         //        browseArray.append(BrowseViewController.genres)
         //browseArray = browseArray.sorted(by: <) //TODO: Sorting
         */
        
        //  For Section than use
        //print(browseSectionArray.count)
        for indexValue in 0..<(response.count) {
            if response[indexValue].displayOrder == BrowseViewController.displayOrderOne || response[indexValue].displayOrder == BrowseViewController.displayOrderSix {
                let nameString = response[indexValue].name
                sectionThridArray.append(nameString!)
            }
        }
        //print("Section List :\(sectionThridArray)")
        print("Section List :\(sectionThridArray)")
        browseSectionsItemsArray.append(sectionThridArray)
        browseSectionsItemsArray.append(sectionfourthArray)
        
        self.tableView.reloadData()
    }
}

extension BrowseViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: Table View Data Source and Delegate Methods
    // Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.browseSectionsItemsArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.browseSectionsItemsArray[section] as AnyObject).count
        ///return self.browseArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BrowseTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.browseTableViewCell, for: indexPath) as! BrowseTableViewCell
        let lablestring = self.browseSectionsItemsArray[indexPath.section] [indexPath.row]
        cell.browseTitleLable.text = lablestring as? String
        //cell.setUIForBrowse(indexPathValueIs: indexPath.row, arrayOfValue: self.browseArray)
        cell.backgroundColor = UIColor.clear
        return cell
    }
    // Delegate Methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Selected Browse is: \(self.browseArray[indexPath.row])")
        print("Selected Browse is: \(self.browseSectionsItemsArray[indexPath.section] [indexPath.row])")
    }
}


