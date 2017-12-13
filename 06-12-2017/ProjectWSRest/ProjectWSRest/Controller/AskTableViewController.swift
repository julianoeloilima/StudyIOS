//
//  AskTableViewController.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 06/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import Alamofire
import SwiftMessages

class AskTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var navItems: UINavigationItem!
    lazy var resultConsult : [TaskEntity] = [TaskEntity]()
    lazy var filtered : [TaskEntity] = [TaskEntity]()
    let formatter = DateFormatter()
    var titleNavigationBar : UIView?
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func getRequest() {
        resultConsult = TaskDB().selectAll()
        filtered = resultConsult
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellID", for: indexPath) as! TaskTableViewCell
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        let task = self.filtered[indexPath.row]
        
        cell.lblDescription.text = task.taskDescription ?? ""
        cell.lblName.text = task.title ?? ""
        cell.imgIsComplete.isHidden = !task.isComplete
        cell.lblExpirationDate.text = formatter.string(from: task.expirationDate!)

        return cell
    }
    
    private var selectedTaskForEdit : TaskEntity?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        showAddAndSearchButtons()
        if segue.destination is SaveTaksViewController {
            if selectedTaskForEdit != nil {
                (segue.destination as! SaveTaksViewController).task = selectedTaskForEdit!.clone()
            }
            else {
                (segue.destination as! SaveTaksViewController).task = nil
            }
        }
    }
 
    override func viewDidAppear(_ animated: Bool) {
        getRequest()
        selectedTaskForEdit = nil
    }
    
    func showAddAndSearchButtons() {
        self.navigationItem.titleView = self.titleNavigationBar
        let btnSearch = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(showSearch))
        btnSearch.tintColor = UIColor.white
        let btnAdd = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(goToNewItem))
        btnAdd.tintColor = UIColor.white
        navItems.setRightBarButtonItems([btnAdd, btnSearch], animated: false)
    }
    
    
    @objc func goToNewItem() {
        selectedTaskForEdit = nil
        self.performSegue(withIdentifier: "detailTask", sender: self)
    }

    @objc func showSearch() {
        navItems.setRightBarButtonItems([], animated: false)
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Pesquisar"
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.navigationItem.titleView = searchBar
        searchBar.tintColor = UIColor.white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "dd/MM/yyyy"
        self.titleNavigationBar = self.navigationItem.titleView
        showAddAndSearchButtons()
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.filtered = resultConsult.filter { task in
                return task.taskDescription!.lowercased().contains(searchText.lowercased()) ||
                       task.title!.lowercased().contains(searchText.lowercased())
            }
        } else {
            self.filtered = resultConsult
        }
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            
            let task = self.filtered[indexPath.row]
            task.syncStatus = SyncStatus.DeleteServer
            TaskDB().delete(item: task)
            
            if task.serverID != nil {
                TaskSync().syncDBToService(item: task)
            }
            
            self.filtered.remove(at: indexPath.row)
            self.tableView.reloadData()
        
            SwiftMessages.successMessage(title: "Sucesso", body: "Tarefa excluída com sucesso.")
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.selectedTaskForEdit = self.filtered[indexPath.row]
            self.performSegue(withIdentifier: "detailTask", sender: self)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.1564054489, green: 0.5728738904, blue: 0.9122014046, alpha: 1)

        
        return [delete, edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTaskForEdit = self.filtered[indexPath.row]
        self.performSegue(withIdentifier: "detailTask", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        if text != nil && text!.count > 0 {
            self.filtered = resultConsult
            tableView.reloadData()
        }
        showAddAndSearchButtons()
}
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filtered = resultConsult
        }
        else {
            self.filtered = resultConsult.filter { task in
                return task.taskDescription!.lowercased().contains(searchText.lowercased()) ||
                    task.title!.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    

}
