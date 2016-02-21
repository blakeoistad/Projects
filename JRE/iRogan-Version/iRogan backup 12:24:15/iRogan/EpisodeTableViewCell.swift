//
//  EpisodeTableViewCell.swift
//  iRogan
//
//  Created by Blake Oistad on 12/6/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    @IBOutlet var episodeGuestNameLabel: UILabel!
    @IBOutlet var episodeNumberLabel: UILabel!
    @IBOutlet var episodeImageView: UIImageView!
    @IBOutlet var episodeDateLabel: UILabel!
    
    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
