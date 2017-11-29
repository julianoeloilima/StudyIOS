//
//  TableViewCell.swift
//  DynamicPrototypes
//
//  Created by Aloc SP08608 on 29/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgCell: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgCell.image? = (imgCell.image?.withRenderingMode(.alwaysTemplate))!
        imgCell.tintColor = UIColor.black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
