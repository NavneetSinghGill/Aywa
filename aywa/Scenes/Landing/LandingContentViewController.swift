//
//  LandingContentViewController.swift
//  aywa
//
//  Created by Zoeb on 11/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

let landingScreenDetailArabicLabelTag = 11
let landingScreenDetailEnglishLabelTag = 12

class LandingContentViewController: UIViewController {
    var pageIndex: Int = 0
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var initialHeaderView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var upperLogo: UIImageView!
    @IBOutlet weak var upperLogoPage5: UIImageView!
    
    @IBOutlet weak var bottomTextView: UIView!
    @IBOutlet weak var leftBottomTextView: UIView!
    @IBOutlet weak var middleBottomTextView: UIView!
    @IBOutlet weak var rightBottomTextView: UIView!
    @IBOutlet weak var arabicTextLabel: UILabel!
    @IBOutlet weak var englishTextLabel: UILabel!
    
    @IBOutlet weak var lastPageView: UIView!
    @IBOutlet weak var lastPageHDLabel: UILabel!
    @IBOutlet weak var lastPageTVLabel: UILabel!
    @IBOutlet weak var lastPageDollarLabel: UILabel!
    @IBOutlet weak var lastPageGlobeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if pageIndex != 4 {
            bottomTextView.alpha = 0
            UIView.animate(withDuration: 1, animations: {
                self.bottomTextView.alpha = 1
            })
            animateBottomViewiPad()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateBottomViewiPad() {
        if isiPad {
            var viewToAnimate: UIView?
            if pageIndex == 0 {
                viewToAnimate = middleBottomTextView
            } else if pageIndex == 1 || pageIndex == 2 {
                viewToAnimate = leftBottomTextView
            } else if pageIndex == 3 {
                viewToAnimate = rightBottomTextView
            }
            (viewToAnimate?.viewWithTag(landingScreenDetailArabicLabelTag) as! UILabel).text = landingScreenTextArabic[pageIndex]
            (viewToAnimate?.viewWithTag(landingScreenDetailEnglishLabelTag) as! UILabel).text = landingScreenTextEnglish[pageIndex]
            viewToAnimate?.layoutIfNeeded()
            viewToAnimate?.isHidden = false
            
            viewToAnimate?.alpha = 0
            UIView.animate(withDuration: 1, animations: {
                viewToAnimate?.alpha = 1
            })
        }
    }
    
    // MARK: - Private Methods
    
    func setup(){
        initialHeaderView.isHidden = pageIndex != 0
        backgroundImageView.image = UIImage(named: "pageContentImage\(pageIndex+1)".adjustForDevice())
        
        lastPageView.isHidden = pageIndex != 4
        bottomTextView.isHidden = pageIndex == 4
        
        if !isiPad {
            subtitleLabel.text = "Movies & TV Shows\nOn demand"
            upperLogo.isHidden = pageIndex == 0 || pageIndex == 3
            
            arabicTextLabel.text = landingScreenTextArabic[pageIndex]
            englishTextLabel.text = landingScreenTextEnglish[pageIndex]
            
            lastPageHDLabel.text = "Enjoy the best entertainment\nexperience in HD."
            lastPageTVLabel.text = "Watch on your PC, TV,\nphone and tablet."
            lastPageDollarLabel.text = "Onetime payment options\navailable."
            lastPageGlobeLabel.text = "Unlimited streaming\nanytime anywhere."
        } else {
            upperLogo.isHidden = pageIndex == 0 || pageIndex == 3 || pageIndex == 4
            
            upperLogoPage5.isHidden = pageIndex != 4
            
            leftBottomTextView.isHidden = true
            middleBottomTextView.isHidden = true
            rightBottomTextView.isHidden = true
            
            lastPageHDLabel.text = "Enjoy the best entertainment experience\nin HD."
            lastPageTVLabel.text = "Watch on your PC, TV, phone and tablet."
            lastPageDollarLabel.text = "Onetime payment options available."
            lastPageGlobeLabel.text = "Unlimited streaming anytime anywhere."
        }
    }
    
    
    
    let landingScreenTextEnglish = [
        !isiPad ? "Watch top movies and\nlatest hits, anywhere,\nanytime." : "Watch top movies and latest hits,\nanywhere, anytime.",
        !isiPad ? "Binge-watch whole seasons\nof TV shows and series,\ncommercial free." : "Binge-watch whole seasons of TV\nshows and series, commercial\nfree.",
        !isiPad ? "Timeless classics. Rediscover\nthe greatest movies of all-time." : "Timeless classics.\nRediscover the greatest\nmovies of all-time.",
        !isiPad ? "Cartoons, animations,\neducational shows, &\nmore." : "Cartoons, animations,\neducational shows, & more.",
                                           ""]
    
    let landingScreenTextArabic = [!isiPad ?". أحدث و أجمل الأفلام": " أحدث و أجمل الأفلام و المسلسلات.",
                                          ".دراما لا تنتهي",
                                          ".روائع الزمن الجميل",
                                          ".برامج اطفال هادفة",
                                          ""]
    
    
}
