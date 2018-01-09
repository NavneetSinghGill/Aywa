//
//  SearchViewController.swift
//  aywa
//
//  Created by Zoeb on 22/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SearchDisplayLogic: class
{
    func displaySomething(viewModel: Search.Something.ViewModel)
}

class SearchViewController: UIViewController, SearchDisplayLogic, UISearchResultsUpdating, UISearchControllerDelegate
{
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    let verticalCellHeight: CGFloat = 235
    let horizontalCellHeight: CGFloat = 175
    
    var arrayOfSearch = [Home.Section.Response]()
    var mArrryFilteredSearchList = [Home.Section.Response]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    //MARK: Initial Setup
    private func initialiseView() {
        // Do any additional setup after loading the view.
        //navigationBarWithLeftSideTitle(isTitle: true, titleName: "Search")
        self.updateNavigationBarColor()
        configureSearchController()
        
        let searchNIB = UINib(nibName: Identifiers.homeTableCell, bundle: nil)
        tableView.register(searchNIB, forCellReuseIdentifier: Identifiers.homeTableCell)
        
        let homeViewController  = self.tabBarController?.viewControllers?.first as! HomeViewController!
        arrayOfSearch = (homeViewController?.sectionArray)!
        self.tableView.separatorStyle = .none
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
        if mArrryFilteredSearchList.isEmpty || searchController.searchBar.text! == "" {
            self.tableView.isHidden = true
            self.defaultLabelForEmptyTableView.isHidden = false
        }
        else {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.isHidden = false
            self.defaultLabelForEmptyTableView.isHidden = true
        }
        
    }
    
    // MARK: Do Search
    
    @IBOutlet weak var defaultLabelForEmptyTableView: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func displaySomething(viewModel: Search.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder =  NSAttributedString(string: "shows or stars", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont(name: "Helvetica", size: 18)
        navigationItem.searchController = searchController
        //navigationItem.titleView = searchController.searchBar
        // self.navigationController?.navigationItem.titleView = searchController.searchBar
    }
    
}
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- TableView Delegate And Datasource Methods
    //MARK: Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.searchBar.text! == "" {
            self.tableView.isHidden = true
            self.defaultLabelForEmptyTableView.isHidden = false
            return 0
        } else {
            self.tableView.isHidden = false
            self.defaultLabelForEmptyTableView.isHidden = true
            return mArrryFilteredSearchList.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.homeTableCell, for: indexPath) as! HomeTableViewCell
        if self.searchController.searchBar.text! == "" {
        }
        else {
            if mArrryFilteredSearchList[indexPath.row].configuration == "E" {
                cell.cellAlignment = .Horizontal
            } else {
                cell.cellAlignment = .Vertical
            }
            cell.setCollectionView(forRow: indexPath.row, sectionData: mArrryFilteredSearchList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return horizontalCellHeight
        }
        return verticalCellHeight
    }
    //MARK:-  UISearchResultsUpdating delegate
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text! == ""{
            self.tableView.isHidden = true
            self.defaultLabelForEmptyTableView.isHidden = false
        }
        else{
            mArrryFilteredSearchList = arrayOfSearch.filter { ($0 ).name!.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        if !mArrryFilteredSearchList.isEmpty{
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
        self.tableView.reloadData()
    }
}
