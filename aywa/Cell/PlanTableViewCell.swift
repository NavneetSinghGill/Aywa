//
//  PlanTableViewCell.swift
//  aywa
//
//  Created by Navneet Singh on 18/01/18.
//  Copyright © 2018 Alpha Solutions. All rights reserved.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var membershipLabel: UILabel!
    @IBOutlet weak var membershipAmountLabel: UILabel!
    @IBOutlet weak var membershipDurationLabel: UILabel!
    @IBOutlet weak var currencyAmountLabel: UILabel!
    @IBOutlet weak var paymentLabel: UILabel!
    
    var isSelectedPlan: Bool = false {
        didSet {
            if isSelectedPlan {
                containerView.backgroundColor = .white
                membershipLabel.textColor = .black
                membershipAmountLabel.textColor = .black
                membershipDurationLabel.textColor = .black
                currencyAmountLabel.textColor = .black
                paymentLabel.textColor = .black
            } else {
                containerView.backgroundColor = .clear
                membershipLabel.textColor = .white
                membershipAmountLabel.textColor = .white
                membershipDurationLabel.textColor = .white
                currencyAmountLabel.textColor = .white
                paymentLabel.textColor = .white
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
