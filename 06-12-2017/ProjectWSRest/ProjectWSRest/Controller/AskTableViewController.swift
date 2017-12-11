//
//  AskTableViewController.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 06/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import Alamofire

class AskTableViewController: UITableViewController, UISearchResultsUpdating {
    
    //var resultConsult : ResultConsult<Task>? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var resultConsult : [TaskEntity] = [TaskEntity]()
    lazy var filtered : [TaskEntity] = [TaskEntity]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func getRequest() {
        /*
        TaskService().getTasks(onSuccess: { response in
            self.resultConsult = (response?.body)!
            if self.resultConsult != nil && self.resultConsult!.results != nil {
                self.filtered = self.resultConsult!.results!
            }
            else {
                self.filtered = [Task]()
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        }, onError: { _ in
            let alert = UIAlertController(title: "Erro",
                                          message: "Houve algum problema", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }, always: {
            //hide loading
        })
        */
        
        filtered = TaskDB().selectAll()
        
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellID", for: indexPath) as! TaskTableViewCell
        
        let task = self.filtered[indexPath.row]
        
        cell.lblDescription.text = task.taskDescription ?? ""
        cell.lblName.text = task.title ?? ""

        return cell
    }
    
    private var selectedTaskForEdit : TaskEntity?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
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
                
            let alert = UIAlertController(title: "Sucesso",
                                              message: "Excluído com sucesso.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            /*
            TaskService().delete(id: task.serverID!, onSuccess: { response in
                
                self.filtered.remove(at: indexPath.row)
                self.tableView.reloadData()
                
                let alert = UIAlertController(title: "Sucesso",
                                              message: "Excluído com sucesso.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }, onError: { _ in
                let alert = UIAlertController(title: "Erro",
                                              message: "Erro ao excluir.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }, always: {
                
            })
 
            }*/
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.selectedTaskForEdit = self.filtered[indexPath.row]
            self.performSegue(withIdentifier: "detailTask", sender: self)
        }
        
        edit.backgroundColor = UIColor.blue
        
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
    

}
