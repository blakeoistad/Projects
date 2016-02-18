//
//  CustomTableViewCell.swift
//  xmlAGAIN
//
//  Created by Blake Oistad on 11/28/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet var episodeTitleLabel: UILabel!
    @IBOutlet var episodeNumberLabel: UILabel!
    @IBOutlet var episodeDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
