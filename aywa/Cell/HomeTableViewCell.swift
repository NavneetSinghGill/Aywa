//
//  HomeTableViewCell.swift
//  aywa
//
//  Created by Bestpeers on 19/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var SectionTitle: UILabel!
    
    var cellAlignment: CellAlignment = .Vertical
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib1 = UINib(nibName: Identifiers.homeImageVerticalCollectionViewCell, bundle: Bundle.main)
        collectionView.register(nib1, forCellWithReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell)
        
        let nib2 = UINib(nibName: Identifiers.homeImageHorizontalCollectionViewCell, bundle: Bundle.main)
        collectionView.register(nib2, forCellWithReuseIdentifier: Identifiers.homeImageHorizontalCollectionViewCell)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
    
    func setCollectionView(forRow row: Int) {
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    //MARK:- CollectionView Delegate And Datasource Methods
    //MARK: Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeImagesCollectionViewCell
        if cellAlignment == .Vertical {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell, for: indexPath) as! HomeImagesCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeImageHorizontalCollectionViewCell, for: indexPath) as! HomeImagesCollectionViewCell
        }
        return cell
    }
    
    //MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.contentView.frame.size.height
        
        if cellAlignment == .Vertical {
            return CGSize(width: height * Constants.generalVerticalCellAspectRatio, height: height)
        }
        return CGSize(width: height * Constants.generalHorizontalCellAspectRatio, height: height)
    }
    
}
