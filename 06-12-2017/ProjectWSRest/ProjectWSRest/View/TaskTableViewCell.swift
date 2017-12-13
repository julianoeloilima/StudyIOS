//
//  TaskTableViewCell.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 06/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgIsComplete: UIImageView!
    @IBOutlet weak var lblExpirationDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let topLineView = UIView(frame: CGRect(x: 26, y: self.bounds.size.height - 1, width: self.bounds.size.width * 3 + 26, height: 1))
        topLineView.backgroundColor = #colorLiteral(red: 0.8469749093, green: 0.8471175432, blue: 0.8469561338, alpha: 1)
        self.addSubview(topLineView)
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
