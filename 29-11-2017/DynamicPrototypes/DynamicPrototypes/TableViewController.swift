//
//  TableViewController.swift
//  DynamicPrototypes
//
//  Created by Aloc SP08608 on 29/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    private let qtOfRowsInSection = 10
    private let qtOfSections = 2
    private var scores : [HiScore]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scores = GenerateInstances.generateHiScore(quantityInstances: (UInt(qtOfSections * qtOfRowsInSection)))
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section number: \(section)"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return qtOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qtOfRowsInSection
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)

        let hiScore = getHiScore(indexPath: indexPath)
        
        let custom = cell as! CustomTableViewCell
        custom.lblNome.text = hiScore.name
        
        //cell.textLabel?.text = hiScore.name
        //cell.detailTextLabel?.text = "Score: \(hiScore.rating)"

        //let imgView = UIImageView(image: #imageLiteral(resourceName: "Cancel"))
        //cell.backgroundColor = UIColor.gray
        //cell.accessoryView = imgView
        return cell
    }
    
    private func getHiScore(indexPath: IndexPath) -> HiScore {
        let index = (indexPath.section * qtOfSections) + indexPath.row
        return scores![index]
    }

}
