//
//  SchoolDataTableCell.swift
//  CodableDemoProject
//
//  Created by Dipak on 31/05/18.
//  Copyright © 2018 Dipak. All rights reserved.
//

import UIKit

class SchoolDataTableCell: UITableViewCell {

    @IBOutlet weak var schoolImageView: UIImageView!
    @IBOutlet weak var schoolCodeLabel: UILabel!
    @IBOutlet weak var schoolURLLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
