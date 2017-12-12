//
//  RequestManager.swift
//  SaitamaCycles
//
//  Created by Zoeb on 05/06/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class RequestManager: NSObject {
    
    //MARK: Authentication API
    
    func performLogin(request:Login.Request, completion:@escaping CompletionHandler){
        performAuthentication(request: request, authType: .LoginType, completion: completion)
    }
    
    func performSignup(request:Signup.Request, completion:@escaping CompletionHandler){
        performAuthentication(request: request, authType: .SignupType, completion: completion)
    }
    
    func performAuthentication(request:BaseRequest, authType: AuthType, completion:@escaping CompletionHandler){
        if ApplicationDelegate.isNetworkAvailable(){
            if authType.isLoginViewActivated() {
                
                RealAPI().postObject(request:request, completion:completion)
            }
            else{
                RealAPI().putObject(request:request, completion:completion)
            }
        }
        else{
            completion(false, Constants.kNoNetworkMessage)
            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
        }
    }
    
//    //MARK: Payment Creation API
//
//    func performPaymentCreation(placeId:String, creditCard:CreditCardModel, completion:@escaping CompletionHandler){
//        if ApplicationDelegate.isNetworkAvailable{
//            Interface().paymentCreation(request: Request().initwithPaymentCreationRequest(placeId: placeId, creditCard: creditCard), completion: completion)
//        }
//        else{
//            completion(false, Constants.kNoNetworkMessage)
//            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
//        }
//    }
//
//    //MARK: Payment List API
//
//    func getPaymentList(completion:@escaping CompletionHandler){
//        if ApplicationDelegate.isNetworkAvailable{
//            Interface().paymentList(request: Request().initwithPaymentListRequest(), completion: completion)
//        }
//        else{
//            completion(false, Constants.kNoNetworkMessage)
//            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
//        }
//    }
//
//    //MARK: Place List API
//
//    func getPlaceList(completion:@escaping CompletionHandler){
//        if ApplicationDelegate.isNetworkAvailable{
//            Interface().getPlaceList(request: Request().initwithPlacesRequest(), completion: completion)
//        }
//        else{
//            completion(false, Constants.kNoNetworkMessage)
//            BannerManager.showFailureBanner(subtitle: Constants.kNoNetworkMessage)
//        }
//    }
}
