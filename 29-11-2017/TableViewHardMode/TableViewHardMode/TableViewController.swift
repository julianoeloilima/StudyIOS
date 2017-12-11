//
//  TableViewController.swift
//  TableViewHardMode
//
//  Created by Aloc SP08608 on 29/11/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import DataKit


class TableViewController: UITableViewController {

    let maxSections = 5
    let maxRows = 15
    lazy var dataIcon : [Int: [Icon]] = [:]
    lazy var dataImages : [Int: [NetworkImage]] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        printHello()
        self.dataIcon = generateIcons(maxSections, maxRows)
        self.dataImages = generateImages(maxSections, maxRows)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataIcon.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataIcon[section]?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 154
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
/*
        let index = indexPath.row % 3
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell", for: indexPath)
            
            guard let content = self.dataIcon[indexPath.section]?[indexPath.row] else  {
                return tableView.dequeueReusableCell(withIdentifier: "placeHolder", for: indexPath)
            }
            
            cell.textLabel?.text = content.name
            cell.detailTextLabel?.text = content.description
            cell.imageView?.image?.withRenderingMode(.alwaysTemplate)
            cell.imageView?.image = UIImage(named: content.imageName)
            if #available(iOS 10.0, *) {
                cell.imageView?.tintColor = UIColor(displayP3Red: CGFloat(normalizedRandom()), green: CGFloat(normalizedRandom()), blue: CGFloat(normalizedRandom()), alpha: 1.0)
            } else {
                cell.imageView?.tintColor = UIColor.black
            }
            return cell
        }
        else if index == 1 {
 */
            let cell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: "teste2", for: indexPath) as! TableViewCell

            let content = self.dataImages[indexPath.section]![indexPath.row]

        
//            guard let content = self.dataImages[indexPath.section]?[indexPath.row] else  {
//                return tableView.dequeueReusableCell(withIdentifier: "placeHolder", for: indexPath)
//            }
            //cell.lblTitle.text = content.name
            //cell.lblDetail.text = content.description
            cell.img.downloadImageAsync(url: URL(string: content.link)!)
            
            return cell
/*
        }
         
    
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            
            guard let content = self.dataImages[indexPath.section]?[indexPath.row] else  {
                return tableView.dequeueReusableCell(withIdentifier: "placeHolder", for: indexPath)
            }
            cell.textLabel?.text = content.name
            cell.detailTextLabel?.text = content.description
            cell.imageView?.downloadImageAsync(url: URL(string: content.link)!)

            return cell
        }
        
        
*/
        
    }

}
