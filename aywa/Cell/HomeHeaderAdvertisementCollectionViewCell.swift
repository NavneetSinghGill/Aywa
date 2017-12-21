//
//  HomeAdvertisementCollectionViewCell.swift
//  aywa
//
//  Created by Bestpeers on 12/18/17.
//  Copyright © 2017 Alpha Solutions. All rights reserved.
//

import UIKit
import SDWebImage

protocol HomeHeaderAdvertisementCellProtocol {
    func cellTapped(with index: Int)

}

class HomeHeaderAdvertisementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var advertImageView: UIImageView!
    @IBOutlet weak var videoImageIcon: UIImageView!
    @IBOutlet weak var titleImageView: UIImageView!
    
    var index: Int!
    var homeHeaderAdvertisementDelegate: HomeHeaderAdvertisementCellProtocol?

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

    //MARK: For Setup Cell Details
    func setUIForSliderBanner(indexPathValueIs: Int , arrayOfValue: [HomeSliderBanner.SliderBanner.Banners] ) {
        let urlString = (arrayOfValue[indexPathValueIs]).image
        let urlStringTitleImage = (arrayOfValue[indexPathValueIs]).titleImage
       
        if let styleTypeDetails = (arrayOfValue[indexPathValueIs]).styleType {
            print(styleTypeDetails)
            isVideo = true
        }
        else{
            print("No styleTypeDetails")
            isVideo = false

        }
        
         setUpImage(bgImageName: urlString, TitleImageName: urlStringTitleImage)
      
    }
    func setUpImage(bgImageName: String?, TitleImageName: String? ) {
            advertImageView.sd_setImage(with: URL(string:bgImageName!), placeholderImage: UIImage(named: "placeholder.png"))
            titleImageView.sd_setImage(with: URL(string:TitleImageName!), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
}
