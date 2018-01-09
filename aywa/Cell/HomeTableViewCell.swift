//
//  HomeTableViewCell.swift
//  aywa
//
//  Created by Zoeb on 19/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    @IBOutlet weak var SectionTitle: UILabel!
    
    @IBAction func cellOptionButtonTapped(_ sender: Any) {
        print("Cell Option Button Tapped")
    }
    var cellAlignment: CellAlignment = .Vertical
    var homeViewController: HomeViewController?
    var sectionData : Home.Section.Response?
    
    var indexOfCell: Int?
    
    //var tableViewIndexValue: Int?
    
    
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
    
    func setCollectionView(forRow row: Int, sectionData: Home.Section.Response) {
        indexOfCell = row
        collectionView.tag = row
        self.sectionData = sectionData
        SectionTitle!.text = sectionData.name!
        self.collectionView.reloadData()
    }
    
    //MARK:- CollectionView Delegate And Datasource Methods
    //MARK: Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (sectionData!.shows?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeImagesCollectionViewCell
        print(indexPath.row)
        if cellAlignment == .Vertical {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeImageVerticalCollectionViewCell, for: indexPath) as! HomeImagesCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.homeImageHorizontalCollectionViewCell, for: indexPath) as! HomeImagesCollectionViewCell
        }
        cell.cellAlignment = self.cellAlignment
        cell.setUICollectionViewCell(forRow: indexOfCell! , show: (self.sectionData?.shows![indexPath.item])!)

        print("\n\nindex: \(String(describing: indexOfCell)), collecIndex:\(indexPath.item)")
        return cell
    }
    
    //MARK: Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = self.collectionView.frame.size.height
        
        if cellAlignment == .Vertical {
            return CGSize(width: height * Constants.generalVerticalCellAspectRatio, height: height)
        }
        return CGSize(width: height * Constants.generalHorizontalCellAspectRatio, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Collection view at row \(collectionView.tag) selected index path \(indexPath)")
    }
}
