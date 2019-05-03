//
//  RestaurantCell.swift
//  JEDemo
//
//  Created by Raynelle on 26/04/2019.
//  Copyright © 2019 Raynelle. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblUsername: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
