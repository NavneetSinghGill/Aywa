//
//  HomeAdvertisementCollectionViewCell.swift
//  aywa
//
//  Created by Bestpeers on 12/18/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit

class HomeHeaderAdvertisementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var advertImageView: UIImageView!
    @IBOutlet weak var videoImageIcon: UIImageView!
    
    var isVideo: Bool {
        get {
            return !videoImageIcon.isHidden
        }
        set {
            videoImageIcon.isHidden = !newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
