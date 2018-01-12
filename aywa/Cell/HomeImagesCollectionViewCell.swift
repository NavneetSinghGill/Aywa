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
    func setUIShowsCollectionViewCell(shows: TVShows.MyListShows.Response) {
        var setURLImageSting: String!
        if self.cellAlignment == .Vertical {
            setURLImageSting = shows.image2x2
        }
        else{
            setURLImageSting = shows.image1x2
        }
        self.setUICellImage(strImageName: setURLImageSting)
    }
    // Set Cell UI For Movies
    func setUIMoviesCollectionViewCell(forRow row: Int, show: Movies.MyListMovies.Response) {
        
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
        if self.cellAlignment == .Vertical {
            displayImageView.sd_setImage(with: URL(string:strImageName), placeholderImage: UIImage(named: "placeholderVertical"))
        } else {
            displayImageView.sd_setImage(with: URL(string:strImageName), placeholderImage: UIImage(named: "placeholderHorizontal"))
        }
    }
}
