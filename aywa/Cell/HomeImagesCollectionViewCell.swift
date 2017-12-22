//
//  HomeImagesCollectionViewCell.swift
//  aywa
//
//  Created by Bestpeers on 19/12/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class HomeImagesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var displayImageView: UIImageView!
    var cellAlignment: CellAlignment = .Vertical
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUICollectionViewCell(forRow row: Int, show: Home.Section.Shows) {
        
        var setURLImageSting: String!
        if self.cellAlignment == .Vertical {
            setURLImageSting = show.image2x2
        }
        else{
            setURLImageSting = show.image1x2
        }
        self.setUICellImage(strImageName: setURLImageSting)
    }
    
    func setUICellImage(strImageName: String) {
        print(strImageName)
        displayImageView.sd_setImage(with: URL(string:strImageName))//, placeholderImage: UIImage(named: "placeholder.png"))
    }
}
