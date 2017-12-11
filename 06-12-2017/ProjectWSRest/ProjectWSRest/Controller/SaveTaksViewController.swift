//
//  SaveTaksViewController.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class SaveTaksViewController: UIViewController {

    var task : TaskEntity?
    
    @IBOutlet weak var txfTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var swtComplete: UISwitch!
    @IBOutlet weak var dtpExpirationDate: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let t = self.task {
            txfTitle.text = t.title
            txtDescription.text = t.taskDescription!
            swtComplete.isOn = t.isComplete
        }
        else {
            txfTitle.text = ""
            txtDescription.text = ""
            swtComplete.isOn = false
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData() {
        task!.isComplete = swtComplete.isOn
        task!.taskDescription = txtDescription.text
        task!.title = txfTitle.text
        task!.expirationDate = dtpExpirationDate.date
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        let msg : String
        if task == nil {
            task = TaskEntity()
            task!.syncStatus = SyncStatus.AddServer
            loadData()
            TaskDB().insert(item: task!)
            msg = "Inserido com sucesso."
        }
        else {
            loadData()
            if task!.serverID != nil {
                task!.syncStatus = SyncStatus.UpdateServer
            }
            TaskDB().update(item: task!)
            msg = "Atualizado com sucesso."
        }

        TaskSync().syncDBToService(item: task!)

        let alert = UIAlertController(title: "Sucesso",
                                      message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        

        /*
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: dtpExpirationDate.date)
        
        
        let taskService = Task()
        taskService.taskDescription = task!.taskDescription
        taskService.expirationDate = strDate
        taskService.title = task!.title
        taskService.isComplete = task!.isComplete
        
        
        if task!.syncStatus == SyncStatus.UpdateServer {
            taskService.id = task!.serverID
            taskDB.update(item: task!)
            TaskService().update(task: taskService, onSuccess: { response in
                
                let serverID = response!.body!.id
                
                self.task = self.task!.clone()
                self.task!.serverID = serverID
                self.task!.syncStatus = SyncStatus.Syncronized
                taskDB.update(item: self.task!)

                let alert = UIAlertController(title: "Sucesso",
                                              message: "Atualizado com sucesso.", preferredStyle: .alert)

                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)

            }, onError: { _ in
                let alert = UIAlertController(title: "Sucesso",
                                              message: "Atualizado com sucesso no dispositivo. Quando estiver online seus dados serão sincronizados.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }, always: {

            })
            
        }
        else {
            taskDB.insert(item: task!)
            taskService.id = nil

            TaskService().add(task: taskService, onSuccess: { response in
                
                self.task = self.task!.clone()
                self.task!.serverID = response?.body?.id
                self.task!.syncStatus = SyncStatus.Syncronized
                taskDB.update(item: self.task!)
                
                let alert = UIAlertController(title: "Sucesso",
                                              message: "Inserido com sucesso.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }, onError: { _ in
                let alert = UIAlertController(title: "Sucesso",
                                              message: "Inserido com sucesso no dispositivo. Quando estiver online seus dados serão sincronizados.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }, always: {
                
            })
        }
 */
        
    }


}
