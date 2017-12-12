//
//  SaveTaksViewController.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit
import DatePickerDialog
import SwiftMessages

class SaveTaksViewController: UIViewController {

    var task : TaskEntity?
    
    @IBOutlet weak var txfTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var swtComplete: UISwitch!
    @IBOutlet weak var lblExpirationDateDesc: UILabel!
    
    let formatter = DateFormatter()
    var selectedDate : Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "dd/MM/yyyy"
        self.selectedDate = Date()
        
        if let t = self.task {
            txfTitle.text = t.title
            txtDescription.text = t.taskDescription!
            swtComplete.isOn = t.isComplete
            if let dt = t.expirationDate {
                self.selectedDate = dt
            }
            self.lblExpirationDateDesc.text = "Expira em: \(formatter.string(from: self.selectedDate))"
        }
        else {
            emptyFields()
        }
    }

    private func emptyFields() {
        txfTitle.text = ""
        txtDescription.text = ""
        swtComplete.isOn = false
        self.selectedDate = Date()
        self.lblExpirationDateDesc.text = "Expira em: \(self.formatter.string(from: self.selectedDate))"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSelectDate(_ sender: UIButton) {
        DatePickerDialog(locale: Locale(identifier: "pt_BR")).show("Data", doneButtonTitle: "Ok", cancelButtonTitle: "Cancelar", datePickerMode: .date) {
                (date) -> Void in
            if let dt = date {
                self.selectedDate = dt
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yyyy"
                self.lblExpirationDateDesc.text = "Expira em: \(formatter.string(from: dt))"
            }
        }
    }

    private func loadData() {
        task!.isComplete = swtComplete.isOn
        task!.taskDescription = txtDescription.text
        task!.title = txfTitle.text
        task!.expirationDate = self.selectedDate
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        
        if txfTitle.text!.count == 0 {
            SwiftMessages.warningMessage(title: "Atenção", body: "Informe o título.")
            return
        }

        if txtDescription.text!.count == 0 {
            SwiftMessages.warningMessage(title: "Atenção", body: "Informe a descrição.")
            return
        }

        let msg : String
        let back : Bool
        if task == nil {
            task = TaskEntity()
            task!.syncStatus = SyncStatus.AddServer
            loadData()
            TaskDB().insert(item: task!)
            msg = "Inserido com sucesso."
            back = false
        }
        else {
            loadData()
            if task!.serverID != nil {
                task!.syncStatus = SyncStatus.UpdateServer
            }
            TaskDB().update(item: task!)
            msg = "Atualizado com sucesso."
            back = true
        }

        TaskSync().syncDBToService(item: task!)

        SwiftMessages.successMessage(title: "Sucesso", body: msg)
        
        if !back {
            emptyFields()
        }
        
        /*
        let alert = UIAlertController(title: "Sucesso",
                                      message: msg, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "ok", style: .cancel, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        */

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
