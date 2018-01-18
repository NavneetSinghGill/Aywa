//
//  MyListViewController.swift
//  aywa
//
//  Created by Bestpeers on 09/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import UIKit

class MyListViewController: UIViewController, UIScrollViewDelegate, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    @IBOutlet weak var moviesButton: UIButton!
    @IBOutlet weak var tvButton: UIButton!
    @IBOutlet weak var networkButton: UIButton!
    
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var constantViewLeft: NSLayoutConstraint!
    
    private var pageController: UIPageViewController!
    private var arrVC:[UIViewController] = []
    private var currentPage: Int!
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialiseView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Initial Setup
    private func initialiseView() {
        navigationBarWithLeftSideTitle(isTitle: true, titleName: LocaleKeys.kMyList)
        currentPage = 0
        createPageViewController()
    }
    
    //MARK: - Custom Methods
    
    private func selectedButton(btn: UIButton) {
        
        btn.setTitleColor(UIColor.black, for: .normal)
        constantViewLeft.constant = btn.frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
    private func unSelectedButton(btn: UIButton) {
        btn.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
    }
    //MARK: - IBaction Methods
    @IBAction private func btnOptionTapped(btn: UIButton) {
        pageController.setViewControllers([arrVC[btn.tag-1]], direction: UIPageViewControllerNavigationDirection.reverse, animated: false, completion: {(Bool) -> Void in
        })
        
        resetTabBarForTag(tag: btn.tag-1)
    }
    
    //MARK: - CreatePagination
    
    private func createPageViewController() {
        
        pageController = UIPageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        
        pageController.view.backgroundColor = UIColor.clear
        pageController.delegate = self
        pageController.dataSource = self
        pageController.view.semanticContentAttribute = .forceLeftToRight
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
           
            let actulFramForViewLine = self.viewLine.superview?.convert(self.viewLine.frame, to: self.view)
           
            self.pageController.view.frame = CGRect(x: 0, y: ((actulFramForViewLine?.origin.y)! + self.viewLine.frame.size.height), width: self.view.frame.size.width, height: self.view.frame.size.height - ((actulFramForViewLine?.origin.y)! + self.viewLine.frame.size.height))
        }
        
        // get storyboard
        let storyboard = UIStoryboard(name: "UniversalStoryboard", bundle: nil)
        // instantiate  desired ViewController
        let destinationTabMovieViewController = storyboard.instantiateViewController(withIdentifier: Identifiers.sIdMoviesViewController) as! MoviesViewController
        let destinationTabTVViewController = storyboard.instantiateViewController(withIdentifier: Identifiers.sIdTVShowsViewController) as! TVShowsViewController
         let destinationTabNetworksViewController = storyboard.instantiateViewController(withIdentifier: Identifiers.sIdNetworksViewController) as! NetworksViewController
        
        arrVC = [destinationTabMovieViewController, destinationTabTVViewController, destinationTabNetworksViewController]
        
        pageController.setViewControllers([destinationTabMovieViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        self.addChildViewController(pageController)
        self.view.addSubview(pageController.view)
        
        pageController.didMove(toParentViewController: self)
    }
    
    
    private func indexofviewController(viewCOntroller: UIViewController) -> Int {
        if(arrVC .contains(viewCOntroller)) {
            return arrVC.index(of: viewCOntroller)!
        }
        
        return -1
    }
    
    //MARK: - Pagination Delegate Methods
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index - 1
        }
        
        if(index < 0) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = indexofviewController(viewCOntroller: viewController)
        
        if(index != -1) {
            index = index + 1
        }
        
        if(index >= arrVC.count) {
            return nil
        }
        else {
            return arrVC[index]
        }
        
    }
    
    func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if(completed) {
            currentPage = arrVC.index(of: (pageViewController1.viewControllers?.last)!)
            resetTabBarForTag(tag: currentPage)
        }
    }
    
    //MARK: - Set Top bar after selecting Option from Top Tabbar
    
    private func resetTabBarForTag(tag: Int) {
        
        var sender: UIButton!
        
        if(tag == 0) {
            sender = moviesButton
        }
        else if(tag == 1) {
            sender = tvButton
        }
        else if(tag == 2) {
            sender = networkButton
        }
        
        currentPage = tag
        
        unSelectedButton(btn: moviesButton)
        unSelectedButton(btn: tvButton)
        unSelectedButton(btn: networkButton)
        
        self.selectedButton(btn: sender)
        
    }
    
    //MARK: - UIScrollView Delegate Methods
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let xFromCenter: CGFloat = self.view.frame.size.width-scrollView.contentOffset.x
        let xCoor: CGFloat = CGFloat(viewLine.frame.size.width) * CGFloat(currentPage)
        let xPosition: CGFloat = xCoor - xFromCenter/CGFloat(arrVC.count)
        constantViewLeft.constant = xPosition
    }
}
