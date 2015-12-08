//
//  TableViewCell.swift
//  Wim
//
//  Created by Jeff Zheng on 12/7/15.
//  Copyright © 2015 Jeff Zheng. All rights reserved.
//

import UIKit
import Parse

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

