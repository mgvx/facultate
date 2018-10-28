//
//  TrackCell.swift
//  tut
//
//  Created by Andreea Popescu on 4/25/16.
//  Copyright © 2016 a. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playIcon: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}