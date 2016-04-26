//
//  ClippingCell.swift
//  Scrapbook
//
//  Created by Benjamin Johnson on 26/04/2016.
//  Copyright © 2016 Benjamin Johnson. All rights reserved.
//

import UIKit

class ClippingCell: UITableViewCell {

    @IBOutlet weak var clippingImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
