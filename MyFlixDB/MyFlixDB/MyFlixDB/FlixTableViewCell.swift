//
//  FlixTableViewCell.swift
//  MyFlixDB
//
//  Created by Blake Oistad on 4/3/16.
//  Copyright © 2016 Blake Oistad. All rights reserved.
//

import UIKit

class FlixTableViewCell: UITableViewCell {

    //MARK: - Properties
    
    @IBOutlet weak var flickTitleLabel: UILabel!
    @IBOutlet weak var flickReleaseDateLabel: UILabel!
    @IBOutlet weak var flickDirectorLabel: UILabel!
    
    
    //MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
