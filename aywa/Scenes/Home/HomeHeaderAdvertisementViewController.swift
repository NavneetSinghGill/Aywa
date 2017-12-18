//
//  HomeHeaderAdvertisementViewController.swift
//  aywa
//
//  Created by Bestpeers on 12/18/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class HomeHeaderAdvertisementViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var homeHeaderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let nib = UINib(nibName: Identifiers.homeAdvertCollectionCell, bundle: Bundle.main)
        homeHeaderCollectionView.register(nib, forCellWithReuseIdentifier: Identifiers.homeAdvertCollectionCell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UICollectionView methods
    //MARK: Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeHeaderAdvertisementCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeAdvertCollectionCell, for: indexPath) as! HomeHeaderAdvertisementCollectionViewCell
        //cell.backgroundColor = .green
        return cell
    }
    
    //MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height)
    }

}
