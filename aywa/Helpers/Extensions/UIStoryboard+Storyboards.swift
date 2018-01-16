//
//  UIStoryboard+Storyboards.swift
//  AHStoryboard
//
//  Created by Andyy Hope on 19/01/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    /// The uniform place where we state all the storyboard we have in our application
    
    enum Storyboard: String {
        case Main
        case UniversalStoryboard
        var filename: String {
            if rawValue == "Main"
            {
                return isiPad ? "Main~ipad" : "Main"
            }
            return rawValue
        }
    }
    
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
    
     //MARK:- Get Movies View Controoler
     class func getMoviesViewController() -> MoviesViewController {
     let mainStoryboard  = self.getMainStoryboard()
     return mainStoryboard.instantiateViewController(withIdentifier: Identifiers.sIdMoviesViewController) as! MoviesViewController
     }
    
    //MARK:- Get Home View Controoler
    class func getHomeViewController() -> HomeViewController {
        let mainStoryboard  = self.getMainStoryboard()
        return mainStoryboard.instantiateViewController(withIdentifier: Identifiers.sIdHomeViewController) as! HomeViewController
    }
     
     class func getMainStoryboard() -> UIStoryboard {
     return UIStoryboard(name: "UniversalStoryboard", bundle: nil)
     }
}


