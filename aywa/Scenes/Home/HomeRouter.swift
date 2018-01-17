//
//  HomeRouter.swift
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

@objc protocol HomeRoutingLogic
{
    func routeToMoveHomeBannerViewController()
    func routeSelectedRowDataMoveViewController()
}

protocol HomeDataPassing
{
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing
{
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: Routing
    
    func routeToMoveHomeBannerViewController(){
        let destinationVC = HomeSliderBannerViewController.create(of: .UniversalStoryboard)
        passDataToHomeSliderBannerCatalogId(source: viewController!, destination: destinationVC)
        addHomeBanner(source: viewController!, destination: destinationVC)
    }
    
    // For Move Movie View Controller If TableView Selected Row Vertical or Move Show ViewController (If Row data  Horizontal)
    func routeSelectedRowDataMoveViewController(){
        var destinationVC: UIViewController?
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        let selectedRowTitle = (viewController?.sectionArray[selectedRow!].name!)!
        
        if (viewController?.sectionArray[selectedRow!].configuration!)! == "E" {
            // horizontalCellHeight
            destinationVC = TVShowsViewController.create(of: .UniversalStoryboard)
            passDataToTVShowViewController(source: viewController!, destination: destinationVC as! TVShowsViewController, selectedRowIndex: selectedRow!)
        }
        else{
            destinationVC = MoviesViewController.create(of: .UniversalStoryboard)
            passDataToMoviesViewController(source: viewController!, destination: destinationVC as! MoviesViewController, selectedRowIndex: selectedRow!)
        }
        navigateToSomewhere(source: viewController!, destination: destinationVC!)
        print(selectedRowTitle)
    }
    
    // MARK: Navigation
    // MARK: Navigation
    func navigateToSomewhere(source: HomeViewController, destination: UIViewController){
        source.bpPush(viewController: destination)
    }
    
    func addHomeBanner(source: HomeViewController, destination: UIViewController){
        source.homeHeader = destination
        source.homeHeader.view.bounds.size = CGSize(width: source.view.frame.size.width, height: source.view.frame.size.width * (236/source.view.frame.size.width))
        source.tableView.tableHeaderView = source.homeHeader.view
    }
    
    // MARK: Passing data
    // For Home Banner
    func passDataToHomeSliderBannerCatalogId(source: HomeViewController, destination: HomeSliderBannerViewController){
        destination.catalogIdForHomeSlider = source.catalogIdForHomeSection
    }
    func passDataToMoviesViewController(source: HomeViewController, destination: MoviesViewController, selectedRowIndex: Int){
        // destination.catalogIdForHomeSlider = source.catalogIdForHomeSection
        destination.homeSectionArray = source.sectionArray[selectedRowIndex]
    }
    func passDataToTVShowViewController(source: HomeViewController, destination: TVShowsViewController, selectedRowIndex: Int) {
        destination.homeSectionArray = source.sectionArray[selectedRowIndex]
    }
}
