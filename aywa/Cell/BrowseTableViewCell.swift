//
//  BrowseTableViewCell.swift
//  aywa
//
//  Created by Bestpeers on 02/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import UIKit

class BrowseTableViewCell: UITableViewCell {

    @IBOutlet weak var browseTitleLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setUIForBrowse(indexPathValueIs: Int , arrayOfValue: Array< String > ){
        self.browseTitleLable.text = arrayOfValue[indexPathValueIs]
    }
}
