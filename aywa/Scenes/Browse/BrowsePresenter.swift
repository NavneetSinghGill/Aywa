//
//  BrowsePresenter.swift
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

protocol BrowsePresentationLogic
{
    func presentError(response: Browse.Catalogs.Response)
    func presentScreenData(response: Browse.Catalogs.Response)
    // For Section 
    func presentForSectionError(response: Home.Section.Response)
    func presentForSectionScreenData(response: [Home.Section.Response])
}

class BrowsePresenter: BrowsePresentationLogic
{
  weak var viewController: BrowseDisplayLogic?
  
  // MARK: Do Browse Presenter
    func presentError(response: Browse.Catalogs.Response){
        viewController?.displayBrowseCatalogError(response: response)
    }
    func presentScreenData(response: Browse.Catalogs.Response)
    {
        viewController?.displayBrowserCatalogsResponse(response: response)
    }
    
    // Handle Response For Section
    func presentForSectionError(response: Home.Section.Response){
        viewController?.displayHomeSectionError(response: response)
    }
    func presentForSectionScreenData(response:[Home.Section.Response]){
        viewController?.displayHomeSectionResponse(response: response)
    }
}
