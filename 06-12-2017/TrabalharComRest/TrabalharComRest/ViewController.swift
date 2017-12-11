//
//  ViewController.swift
//  TrabalharComRest
//
//  Created by Aloc SP08608 on 06/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTask") as! TableViewCell
        
        cell.lblName.text = "Nome \(indexPath.row)"
        cell.lblDescription.text = "Descrição \(indexPath.row)"

        return cell
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tableView.dataSource = self
//        self.tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

