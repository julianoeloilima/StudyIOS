//
//  ViewController.swift
//  WebKit
//
//  Created by Aloc SP08608 on 04/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newView = UIView()
        newView.backgroundColor = UIColor.red
        view.addSubview(newView)
        
        newView.translatesAutoresizingMaskIntoConstraints = false

        /*
        let views = ["view": view!, "newView": newView]
        
        NSLayoutConstraint.constraints(withVisualFormat: <#T##String#>, options: <#T##NSLayoutFormatOptions#>, metrics: <#T##[String : Any]?#>, views: <#T##[String : Any]#>)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-(<=0)-[newView(100)]", options: NSLayoutFormatOptions.alignAllCenterY, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(<=0)-[newView(100)]", options: NSLayoutFormatOptions.alignAllCenterX, metrics: nil, views: views)
        
        NSLayoutConstraint.activate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
 */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

