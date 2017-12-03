//
//  ScheduleCellTableViewCell.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 01/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var imgSchedule: UIImageView!
    @IBOutlet weak var lblDescriptionSchedule: UILabel!
    
    @IBOutlet weak var lblPeriodSchedule: UILabel!
    @IBOutlet weak var lblActive: UILabel!
    
    @IBOutlet weak var swActive: UISwitch!
    
    var delegate: ScheduleTableCellGestures?
    var selectedIndexObject: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = true
        self.isMultipleTouchEnabled = true

        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ScheduleTableViewCell.cellLeftSwipeGestureRecognizer(_:)))
        self.addGestureRecognizer(leftSwipeGesture)
        leftSwipeGesture.direction = UISwipeGestureRecognizerDirection.left

        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(ScheduleTableViewCell.cellRightSwipeGestureRecognizer(_:)))
        self.addGestureRecognizer(rightSwipeGesture)
        rightSwipeGesture.direction = UISwipeGestureRecognizerDirection.right

        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(ScheduleTableViewCell.cellLongPressGestureRecognizer(_:)))
        longGesture.minimumPressDuration = 1
        self.addGestureRecognizer(longGesture)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ScheduleTableViewCell.cellTapGestureRecognizer(_:)))
        self.addGestureRecognizer(tapGesture)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @objc func cellLeftSwipeGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        delegate?.willDidCellLeftSwipeGesture(cell : self, objectIndex: selectedIndexObject)
    }

    @objc func cellRightSwipeGestureRecognizer(_ sender: UISwipeGestureRecognizer) {
        delegate?.willDidCellRightSwipeGesture(cell : self, objectIndex: selectedIndexObject)
    }

    @objc func cellLongPressGestureRecognizer(_ sender: UILongPressGestureRecognizer) {
        delegate?.willDidCellLongPressGesture(cell : self, objectIndex: selectedIndexObject)
    }

    @objc func cellTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        delegate?.willDidCellTapGesture(cell : self, objectIndex: selectedIndexObject)
    }

}


protocol ScheduleTableCellGestures {
    
    func willDidCellTapGesture(cell : ScheduleTableViewCell, objectIndex : Int?)
    func willDidCellLeftSwipeGesture(cell : ScheduleTableViewCell, objectIndex : Int?)
    func willDidCellRightSwipeGesture(cell : ScheduleTableViewCell, objectIndex : Int?)
    func willDidCellLongPressGesture(cell : ScheduleTableViewCell, objectIndex : Int?)

}
