//
//  ScrollViewController.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 04/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnChangeScroll: UIButton!
    
    var isToBottom : Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.delegate = self
    }
    
    @IBAction func btnScrollViewClick(_ sender: UIButton) {
        var offset = scrollView.contentOffset
        let bottomY = scrollView.contentSize.height - scrollView.bounds.size.height
        offset.y = isToBottom ? bottomY : 0
        scrollView.setContentOffset(offset, animated: true)

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > scrollView.contentSize.height / 4 {
            isToBottom = false
            btnChangeScroll.setTitle("🔼", for: UIControlState())
        } else {
            isToBottom = true
            btnChangeScroll.setTitle("🔽", for: UIControlState())
        }
    }
    
    func showMsg(title : String, msg : String)
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


