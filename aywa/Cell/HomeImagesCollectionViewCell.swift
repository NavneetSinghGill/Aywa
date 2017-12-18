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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImageSize(imageWidth: CGFloat, imageHeight: CGFloat)  {
        displayImageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
    }
}
