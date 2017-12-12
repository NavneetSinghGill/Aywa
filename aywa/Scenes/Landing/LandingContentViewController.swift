//
//  LandingContentViewController.swift
//  aywa
//
//  Created by Zoeb on 11/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class LandingContentViewController: UIViewController {
    var pageIndex: Int = 0
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var initialHeaderView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var upperLogo: UIImageView!
    
    @IBOutlet weak var bottomTextView: UIView!
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func setup(){
        initialHeaderView.isHidden = pageIndex != 0
        upperLogo.isHidden = pageIndex == 0 || pageIndex == 3
        subtitleLabel.text = "Movies & TV Shows\nOn demand"
        backgroundImageView.image = UIImage(named: "pageContentImage\(pageIndex+1)")
        
        lastPageView.isHidden = pageIndex != 4
        bottomTextView.isHidden = pageIndex == 4
        arabicTextLabel.text = LandingContentViewController.landingScreenTextArabic[pageIndex]
        englishTextLabel.text = LandingContentViewController.landingScreenTextEnglish[pageIndex]
        
        lastPageHDLabel.text = "Enjoy the best entertainment\nexperience in HD."
        lastPageTVLabel.text = "Watch on your PC, TV,\nphone and tablet."
        lastPageDollarLabel.text = "Onetime payment options\navailable."
        lastPageGlobeLabel.text = "Unlimited streaming\nanytime anywhere."
    }
    
    
    
    static let landingScreenTextEnglish = ["Watch top movies and\nlatest hits, anywhere,\nanytime",
                                           "Binge-watch whole seasons\nof TV shows and series,\ncommercial free.",
                                           "Timeless classics. Rediscover\nthe greatest movies of all-time.",
                                           "Cartoons, animations,\neducational shows, &\nmore.",
                                           ""]
    
    static let landingScreenTextArabic = [". أحدث و أجمل الأفلام",
                                          ".دراما لا تنتهي",
                                          ".روائع الزمن الجميل",
                                          ".برامج اطفال هادفة",
                                          ""]
    
    
}
