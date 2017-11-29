//
//  CustomTableViewCell.swift
//  DynamicPrototypes
//
//  Created by Aloc SP08608 on 29/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNome: UILabel!
    @IBOutlet weak var itemLevelOne: UITabBarItem!
    @IBOutlet weak var itemLevelTwo: UITabBarItem!
    @IBOutlet weak var itemLevelThree: UITabBarItem!
    @IBOutlet weak var itemLevelFour: UITabBarItem!
    @IBOutlet weak var itemLevelFive: UITabBarItem!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
