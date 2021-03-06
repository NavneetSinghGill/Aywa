//
//  RequestManager.swift
//  SaitamaCycles
//
//  Created by Zoeb on 05/06/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class RequestManager: NSObject {
    
    //MARK: JWTToken API
    
    func fetchJWTToken(request:BaseRequest, completion:@escaping CompletionHandler){
        if ApplicationDelegate.isNetworkAvailable{
            RealAPI().postObject(request:request, genericResponse: Token.JWTToken.Response.self, completion:completion)
        }
        else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    
    func fetchRefreshToken(request:BaseRequest, completion:@escaping CompletionHandler){
        if ApplicationDelegate.isNetworkAvailable{
            RealAPI().getObject(request:request, genericResponse: Token.JWTToken.Response.self, completion:completion)
        }
        else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    //MARK:- Fetch Slider Banner
    func fetchSliderBanner(request:BaseRequest, completion:@escaping CompletionHandler){
        if ApplicationDelegate.isNetworkAvailable{
            RealAPI().getObject(request:request, genericResponse: HomeSliderBanner.SliderBanner.Response.self, completion:completion)
        }
        else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    
    //MARK:- Fetch Section
    func fetchSection(request: BaseRequest, completion:@escaping CompletionHandler)  {
        if ApplicationDelegate.isNetworkAvailable {
            RealAPI().getObject(request: request, genericResponse: Home.Section.Response.self, completion: completion)
        }else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
  
    //MARK:- Fetch
    func performPostAPI(request:BaseRequest, completion:@escaping CompletionHandler){
        if ApplicationDelegate.isNetworkAvailable{
            RealAPI().postObject(request:request, genericResponse: Common.Response.self, completion:completion)
        }
        else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    
    
    //MARK:- Get Catalogs
    func fetchCatalogs(request: BaseRequest, completion:@escaping CompletionHandler)  {
        if ApplicationDelegate.isNetworkAvailable {
            RealAPI().getObject(request: request, genericResponse: Browse.Catalogs.Response.self, completion: completion)
        }else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    
    //MARK:- fetch Movies
    func fetchMovies(request: BaseRequest, completion:@escaping CompletionHandler)  {
        if ApplicationDelegate.isNetworkAvailable {
            RealAPI().getObject(request: request, genericResponse: Movies.MyListMovies.Response.self, completion: completion)
        }else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    
    //MARK:- fetch Shows
    func fetchShows(request: BaseRequest, completion:@escaping CompletionHandler)  {
        if ApplicationDelegate.isNetworkAvailable {
            RealAPI().getObject(request: request, genericResponse: TVShows.MyListShows.Response.self, completion: completion)
        }else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
}
