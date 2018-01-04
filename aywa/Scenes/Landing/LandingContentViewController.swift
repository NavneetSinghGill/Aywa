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
    
    static var lastPageIndex:Int = 0
    var pageIndex: Int = 0
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var initialHeaderView: UIView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var upperLogo: UIImageView!
    @IBOutlet weak var upperLogoPage5PAD: UIImageView!
    @IBOutlet weak var upperLogoPage1: UIImageView!
    
    @IBOutlet weak var bottomTextView: UIView!
    @IBOutlet weak var leftBottomTextView: UIView!
    @IBOutlet weak var middleBottomTextView: UIView!
    @IBOutlet weak var rightBottomTextView: UIView!
    @IBOutlet weak var arabicTextLabel: UILabel!
    @IBOutlet weak var englishTextLabel: UILabel!
    @IBOutlet weak var leftBottomTextViewEnglishLabelIPad: UILabel!
    
    @IBOutlet weak var lastPageView: UIView!
    @IBOutlet weak var lastPageHDLabel: UILabel!
    @IBOutlet weak var lastPageTVLabel: UILabel!
    @IBOutlet weak var lastPageDollarLabel: UILabel!
    @IBOutlet weak var lastPageGlobeLabel: UILabel!
    
    @IBOutlet weak var hdView: UIView!
    @IBOutlet weak var tvView: UIView!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var dollarView: UIView!
    @IBOutlet weak var globeView: UIView!
    @IBOutlet weak var dollar7View: UIView!
    
    var didExecuteOnceInLifeTimeInDidAppear: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        adjustLeftEnglishLabelAlignmentIPAD()
        
        self.view.bringSubview(toFront: backgroundImageView)
        animateBackground()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.sendSubview(toBack: backgroundImageView)
        if LandingContentViewController.lastPageIndex <= pageIndex || (LandingContentViewController.lastPageIndex == 4 && pageIndex == 0) {
            // default forward direction
            self.view.animateToCenterFromRight()
        }
        else{
            // backward direction
            self.view.animateToCenterFromLeft()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        LandingContentViewController.lastPageIndex = pageIndex
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private Methods
    
    func adjustLeftEnglishLabelAlignmentIPAD() {
        if isiPad {
            switch pageIndex {
            case 1:
                leftBottomTextViewEnglishLabelIPad.textAlignment = .left
            case 2:
                leftBottomTextViewEnglishLabelIPad.textAlignment = .center
            default:
                break
            }
        }
    }
    
    func animateBottomView() {
        if pageIndex != 4 {
            self.bottomTextView.alpha = 1
            animateBottomViewIPAD()
        }
    }
    
    func animateBottomViewIPAD() {
        if !isiPad {
            self.arabicTextLabel?.alpha = 1
            self.englishTextLabel?.alpha = 1
        } else {
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
            viewToAnimate?.alpha = 1
        }
    }
    
    func animatePage5Content() {
        let animationDuration = 0.5
        let differenceOfTime: TimeInterval = 0.2
        let constantDelay: TimeInterval = 0.2
        
        hdView.alpha = 0
        UIView.animate(withDuration: animationDuration,
                       delay: 0 * differenceOfTime + constantDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.hdView.alpha = 1
        }, completion: nil)
        
        tvView.alpha = 0
        UIView.animate(withDuration: animationDuration,
                       delay: 1 * differenceOfTime + constantDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.tvView.alpha = 1
        }, completion: nil)
        
        videoView.alpha = 0
        UIView.animate(withDuration: animationDuration,
                       delay: 2 * differenceOfTime + constantDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.videoView.alpha = 1
        }, completion: nil)
        
        dollarView.alpha = 0
        UIView.animate(withDuration: animationDuration,
                       delay: 3 * differenceOfTime + constantDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.dollarView.alpha = 1
        }, completion: nil)
        
        globeView.alpha = 0
        UIView.animate(withDuration: animationDuration,
                       delay: 4 * differenceOfTime + constantDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.globeView.alpha = 1
        }, completion: nil)
        
        dollar7View.alpha = 0
        UIView.animate(withDuration: animationDuration,
                       delay: 5 * differenceOfTime + constantDelay,
                       options: .curveEaseInOut,
                       animations: {
                        self.dollar7View.alpha = 1
        }, completion: nil)
        
    }
    
    func animateBackground() {
        self.backgroundImageView.image = BackgroundImageManager.shared().backgroundImage
        DispatchQueue.main.async {
            let currentImageName = BackgroundImageManager.shared().pageContentImage + "\(self.pageIndex+1)"
            
            UIView.transition(with: self.backgroundImageView,
                              duration:3,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.backgroundImageView.image = UIImage(named: currentImageName)
                                BackgroundImageManager.shared().backgroundImage = UIImage(named: currentImageName)
                                
            },
                              completion: nil)
        }
    }
    
    func setup(){
        initialHeaderView.isHidden = pageIndex != 0
        backgroundImageView.image = UIImage(named: BackgroundImageManager.shared().pageContentImage + "\(pageIndex+1)")
        lastPageView.isHidden = pageIndex != 4
        bottomTextView.isHidden = pageIndex == 4
        
        if !isiPad {
            subtitleLabel.text = "Movies & TV Shows\nOn demand"
            upperLogo.isHidden = pageIndex == 0 || pageIndex == 3
            
            arabicTextLabel.alpha = 0
            englishTextLabel.alpha = 0
            arabicTextLabel.text = landingScreenTextArabic[pageIndex]
            englishTextLabel.text = landingScreenTextEnglish[pageIndex]
            
            lastPageHDLabel.text = "Enjoy the best entertainment\nexperience in HD."
            lastPageTVLabel.text = "Watch on your PC, TV,\nphone and tablet."
            lastPageDollarLabel.text = "Onetime payment options\navailable."
            lastPageGlobeLabel.text = "Unlimited streaming\nanytime anywhere."
        } else {
            upperLogo.isHidden = pageIndex == 0 || pageIndex == 3 || pageIndex == 4
            
            upperLogoPage5PAD.isHidden = pageIndex != 4
            
            leftBottomTextView.isHidden = true
            middleBottomTextView.isHidden = true
            rightBottomTextView.isHidden = true
            
            lastPageHDLabel.text = "Enjoy the best entertainment experience\nin HD."
            lastPageTVLabel.text = "Watch on your PC, TV, phone and tablet."
            lastPageDollarLabel.text = "Onetime payment options available."
            lastPageGlobeLabel.text = "Unlimited streaming anytime anywhere."
            
            //Bottom Views
            var viewToAnimate: UIView?
            if pageIndex == 0 {
                viewToAnimate = middleBottomTextView
            } else if pageIndex == 1 || pageIndex == 2 {
                viewToAnimate = leftBottomTextView
            } else if pageIndex == 3 {
                viewToAnimate = rightBottomTextView
            }
            viewToAnimate?.alpha = 0
        }
        
        self.animateBottomView()
    }
    
    
    
    let landingScreenTextEnglish = [
        !isiPad ? "Watch top movies and latest \nhits, anywhere, anytime." : "Watch top movies and latest hits,\nanywhere, anytime.",
        !isiPad ? "Binge-watch whole seasons of TV \nshows and series, commercial free." : "Binge-watch whole seasons of TV \nshows and series, commercial free.",
        !isiPad ? "Timeless classics. Rediscover\nthe greatest movies of all-time." : "Timeless classics. Rediscover \nthe greatest movies of all-time.",
        !isiPad ? "Cartoons, animations, \neducational shows, &more." : "Cartoons, animations, educational \nshows, & more.",
        ""]
    
    let landingScreenTextArabic = [!isiPad ?". أحدث و أجمل الأفلام": " أحدث و أجمل الأفلام و المسلسلات.",
                                   ".دراما لا تنتهي",
                                   ".روائع الزمن الجميل",
                                   ".برامج اطفال هادفة",
                                   ""]
    
    
}
