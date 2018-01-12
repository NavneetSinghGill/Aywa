//
//  HomeImagesCollectionViewCell.swift
//  aywa
//
//  Created by Zoeb on 19/12/17.
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
    // Set Cell UI For Home Section
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
    // Set Cell UI For Shows
 
    // For Set UI For Movies Shows And Networks
    func setUICollectionViewCellForShows(forRow row: Int, shows: [Any] ) {
        var setURLImageSting: String!
        
        if let shows_Movies = shows as? [Movies.MyListMovies.Response] {
            if self.cellAlignment == .Vertical {
                setURLImageSting = shows_Movies[row].image2x2
            }
            else{
                setURLImageSting = shows_Movies[row].image1x2
            }
        } else if  let shows_tvShows = shows as? [TVShows.MyListShows.Response] {
            if self.cellAlignment == .Vertical {
                setURLImageSting = shows_tvShows[row].image2x2
            }
            else{
                setURLImageSting = shows_tvShows[row].image1x2
            }
        }
        else  {
        }
        
        self.setUICellImage(strImageName: setURLImageSting)
    }
    
    func setUICellImage(strImageName: String) {
        print(strImageName)
        if self.cellAlignment == .Vertical {
            displayImageView.sd_setImage(with: URL(string:strImageName), placeholderImage: UIImage(named: "placeholderVertical"))
        } else {
            displayImageView.sd_setImage(with: URL(string:strImageName), placeholderImage: UIImage(named: "placeholderHorizontal"))
        }
    }
}
