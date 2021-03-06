//
//  Constants.swift
// WordPower
//
//  Created by Zoeb  on 11/12/17.
//  Copyright (c) 2017 Alpha Solutions. All rights reserved.
//

import Foundation
import UIKit

let ApplicationDelegate = UIApplication.shared.delegate as! AppDelegate

typealias CompletionHandler = (_ success: Bool, _ response: Any?) -> Void

let isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad

let isArabic: Bool = (UIApplication.shared.keyWindow?.effectiveUserInterfaceLayoutDirection == .rightToLeft)

struct Constants {
    
    // MARK: - General Constants
    static let deviceIdentifier = "DeviceIdentifier"
    static let kIsLoggedIn = "IsLoggedIn"
    static let DeviceInfoKey = "device_info"
    static let DeviceTypeKey = "DeviceType"
    static let EmptyString = ""
    static let kErrorMessage = "Something went wrong while processing your request"
    static let kNoNetworkMessage = "No network available"
    static let kContentTypeKey = "Content-Type"
    static let kContentTypeValue = "application/json"
    static let kOriginKey = "Origin"
    static let kOriginValue = "www.aywa.com"
    static let kApiKey = "ApiKey"
    static let kApiKeyValue = "eX2DEXCjXbWVP54iehZmTq95NBS2B8zVyHUQHJNM52Q="
    
    static let kAccessTokenKey = "AccessToken"
    static let kAccessTokenExpiryKey = "AccessTokenExpiry"
    
    static let kRefreshTokenKey = "RefreshToken"
    static let kRefreshTokenLifeKey = "RefreshTokenLife"
    
    static let kAuthorizationkey = "Authorization"
    static let kBearerkey = "Bearer "
    
    static let kAppName = "Aywa"
    static let kChangeBackgroundImageIdentifier = "ChangeBackgroundImageIdentifier"
    
    static let generalHorizontalCellAspectRatio: CGFloat = 476/268
    static let generalVerticalCellAspectRatio: CGFloat = 220/320
    
    // MARK: - User Defaults
    
    // MARK: - Enums
    enum RequestType: NSInteger {
        case GET
        case POST
        case MultiPartPost
        case DELETE
        case PUT
    }
    
    // MARK: - Numerical Constants
    static let StatusSuccess = 1
    static let ResponseStatusSuccess = 200
    static let ResponseStatusCreated = 201
    static let ResponseStatusAccepted = 202
    static let ResponseStatusForbidden = 401
    
    // MARK: - Network Keys
    static let InsecureProtocol = "http://"
    static let SecureProtocol = "https://"
    static let LocalEnviroment = "LOCAL"
    static let StagingEnviroment = "STAGING"
    static let LiveEnviroment = "LIVE"
    
    //MARK: - Signup keys
    static let kEmailKey = "Email"
    static let kPasswordKey = "Password"
    static let kConfirmPassword = "confirmPassword"
    static let kNameKey = "Name"
    static let kBirthdayKey = "Birthday"
    static let kAgeGroupKey = "AgeGroup"
    static let kGenderKey = "Gender"
    static let kCountryKey = "Country"
    static let kCountryNameKey = "CountryName"
    static let kPhoneKey = "Phone"
    static let kIPAddressKey = "IPAddress"
    static let kEmailForEmptyKey = "NoData"
    //MARK: - Login keys
    static let kUserName = "UserName"
    static let kFbToken = "Token"
    //MARK: - SliderBanner keys
    static let kClientTypeKey = "clientType"
    static let kClientTypeValue = 2 // 2 for mobile
    static let kCatalogIdKey = "catalogId"
    
    //MARK: - Section Keys
    static let kMenuSectionsOnlyKey = "MenuSectionsOnly"
    static let kMenuSectionsOnlyValue = "false"
    static let kMenuSectionsTrueValue = "true"
    
    static let kShowTypeKey = "ShowType"
    static let kIncludeShowsKey = "IncludeShows" 
    static let kIncludeShowsValue = "true"
    //MARK: Catalogs Key
    static let kIdKey = "id"
    // MARK:- MyList Movies
    static let kShowTypesKey = "ShowTypes"
    
}

struct Identifiers {
    //CollectionView
    static let homeAdvertCollectionCell = "HomeHeaderAdvertisementCollectionViewCell"
    static let homeImageVerticalCollectionViewCell = "HomeImageVerticalCollectionViewCell"
    static let homeImageHorizontalCollectionViewCell = "HomeImageHorizontalCollectionViewCell"
    // Home TableView
    static let homeTableCell = "HomeTableViewCell"
    // Browse TableView
    static let browseTableViewCell = "BrowseTableViewCell"
    
    //Storyboard Identifiers
    // Home
    static let sIdHomeViewController = "HomeViewController"
    
    //MyListViewController
    static let sIdMyListViewController = "MyListViewController"
    static let sIdMoviesViewController = "MoviesViewController"
    static let sIdTVShowsViewController = "TVShowsViewController"
    static let sIdNetworksViewController = "NetworksViewController"
    
    //PlansViewController
    static let selectPlanTableViewCell = "SelectPlan"
    static let continuePlanTableViewCell = "ContinuePlan"
    static let planTableViewCell = "PlanTableViewCell"
}

struct LocaleKeys {
    static let kSignIn = "SignIn"
    static let kFbSignIn = "FbSignIn"
    
    static let kSignUp = "SignUp"
    static let kFbSignUp = "FbSignUp"
    static let kForgotPassword = "ForgotPassword"
    static let kCheckEmailforNewPassword = "CheckEmailforNewPassword"
    
    static let kBrowse = "Browse".localize()
    static let kPlans = "Plans".localize()
    static let kLogout = "Logout".localize()
    static let kShows = "Shows".localize()
    static let kSearch = "Search".localize()
    static let kMyList = "My List".localize()
    static let kNotifications = "Notifications"
    
    //Browse Identifier for Strings
    static let kMoviesString = "MoviesString".localize()
    static let kTvShowsString = "TvShowsString".localize()
    static let kNetworksString = "NetworksString".localize()
    static let kDocumentariesString = "DocumentariesString".localize()
    static let kKidString = "KidString".localize()
    static let kNewReleasesString = "NewReleasesString".localize()
    static let kRecently_AddedString = "Recently_AddedString".localize()
    static let kGenresString = "GenresString".localize()

    //Images
    static let kBackButton = "backButton"
    
}

enum CellAlignment {
    case Vertical
    case Horizontal
}

// For Show Type
// numeric values   ShowTypes
enum NumericValue:Int{
    case ZERO = 0
    case ONE = 1
    case TWO = 2
    case THREE = 3
    case FOURTH = 4
    case FIFTH = 5
}
