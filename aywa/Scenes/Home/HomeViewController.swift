//
//  HomeViewController.swift
//  aywa
//
//  Created by Bestpeers on 19/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol HomeDisplayLogic: class
{
    func displayError(response: Home.Section.Response)
    func displayHomeScreen(response: [Home.Section.Response])
    
}

class HomeViewController: UIViewController, HomeDisplayLogic, UITableViewDelegate, UITableViewDataSource
{
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    let homeSliderBannerViewController  = "HomeSliderBannerViewController"
    
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
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
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
        // Do any additional setup after loading the view.
       
        let searchNIB = UINib(nibName: Identifiers.homeTableCell, bundle: nil)
        tableView.register(searchNIB, forCellReuseIdentifier: Identifiers.homeTableCell)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.homeHeader = self.storyboard?.instantiateViewController(withIdentifier: homeSliderBannerViewController) as! HomeSliderBannerViewController
        self.homeHeader.view.bounds.size = CGSize(width: self.view.frame.size.width, height: 240)
        self.tableView.tableHeaderView = homeHeader.view
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // showNavigationBar()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
        //  UIApplication.shared.statusBarStyle = .lightContent
        // Call section API
           doSectionAPI()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    var homeHeader = HomeSliderBannerViewController()
    
    var storedOffsets = [Int: CGFloat]()
    let verticalCellHeight: CGFloat = 235
    let horizontalCellHeight: CGFloat = 175
    public var sectionArray = [Home.Section.Response]()
    var sectionDictionary = [String:Home.Section.Response]()
    
    //MARK:- TableView Delegate And Datasource Methods
    //MARK: Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return model.count
        return self.sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.homeTableCell, for: indexPath) as! HomeTableViewCell
        
        if self.sectionArray[indexPath.row].configuration == "E" {
            cell.cellAlignment = .Horizontal
        } else {
            cell.cellAlignment = .Vertical
        }
        cell.setCollectionView(forRow: indexPath.row, sectionData: self.sectionArray[indexPath.row])
         //cell.setCollectionView(forRow: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return horizontalCellHeight
        }
        return verticalCellHeight
    }
    //MARK:- Show Response
    func displayError(response: Home.Section.Response)
    {
        print("Error occured: \(response)")
    }
    
    func displayHomeScreen(response: [Home.Section.Response])
    {
        print("Show Home Section Data!!!")
        sectionArray = response
        self.tableView.reloadData()
        print(response)
      
    }
    
    //MARK: For StatusBarStyle
    //    override var preferredStatusBarStyle: UIStatusBarStyle {
    //        return .lightContent
    //    }
    
    //MARK: For Call Section API
    func doSectionAPI()  {
        let request = Home.Section.Request()
        interactor?.doSectionAPI(request: request)
    }
}
