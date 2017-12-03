//
//  SaveSchedule.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 01/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class ConsultScheduleController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, ScheduleTableCellGestures {
    
    func willDidCellLeftSwipeGesture(cell : ScheduleTableViewCell, objectIndex: Int?) {
        DB.scheduleEditing = self.schedulers[objectIndex!]
        showMsg(title: "Ação", msg: "Editar left \(DB.scheduleEditing!.description)")
    }
    
    func willDidCellRightSwipeGesture(cell : ScheduleTableViewCell, objectIndex: Int?) {
        let schedule = schedulers[objectIndex!]
        let titleMsg : String
        let descMsg : String
        let newStatus : Bool
        let newMsgYes : String

        newStatus = !schedule.active

        if schedule.active {
            titleMsg = "O lembrete está ativo."
            descMsg = "Deseja desativá-lo?"
            newMsgYes = "Lembrete desativado."
        }
        else {
            titleMsg = "O lembrete está desativado."
            descMsg = "Deseja ativá-lo?"
            newMsgYes = "Lembrete ativado."
        }
        
        showMsgYesNo(title: titleMsg, msg: descMsg, yesHandler: ({
            schedule.active = newStatus
            DB.updateSchedule(schedule: schedule)
            self.setCellInfo(cell: cell, item: schedule)
            self.showMsg(title: "Sucesso", msg: newMsgYes)
        }))

    }

    func willDidCellLongPressGesture(cell : ScheduleTableViewCell, objectIndex: Int?) {
        let schedule = schedulers[objectIndex!]
        if schedule.situation == Situation.Pending {
            showMsgYesNo(title: "O lembrete está pendente.", msg: "Deseja marcar o lembrete como finalizado?", yesHandler: ({
                schedule.situation = Situation.Done
                DB.updateSchedule(schedule: schedule)
                self.setCellInfo(cell: cell, item: schedule)
                self.showMsg(title: "Sucesso", msg: "Lembrete finalizado.")
            }))
        }
        else {
            showMsgYesNo(title: "O lembrete está finalizado.", msg: "Deseja voltar lembrete para pendente?", yesHandler: ({
                schedule.situation = Situation.Pending
                DB.updateSchedule(schedule: schedule)
                self.setCellInfo(cell: cell, item: schedule)
                self.showMsg(title: "Sucesso", msg: "Lembrete pendente.")
            }))
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

    func showMsgYesNo(title : String, msg : String, yesHandler : @escaping () -> ())
    {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Sim", comment: "Default action"), style: .`default`, handler: { _ in
            yesHandler()
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Não", comment: "Default action"), style: .`default`, handler: { _ in
            NSLog("The \"Nao\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedulers.count
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cellSchedule", for: indexPath) as! ScheduleTableViewCell
     
        cell.delegate = self
        cell.selectedIndexObject = indexPath.row
        setCellInfo(cell: cell, item: schedulers[indexPath.row])
        return cell
    }
    
    private func setCellInfo(cell : ScheduleTableViewCell, item : Schedule) {
        cell.lblDescriptionSchedule.text = item.description
        cell.swActive.isOn = item.active
        cell.lblPeriodSchedule.text = item.repeatDescription
        if Situation.Done == item.situation {
            cell.imgSchedule.image = #imageLiteral(resourceName: "done") //.withRenderingMode(.alwaysTemplate)
//            cell.imgSchedule.tintColor = UIColor.blue
            
        }
        else {
            cell.imgSchedule.image = #imageLiteral(resourceName: "warning") //.withRenderingMode(.alwaysTemplate)
//            cell.imgSchedule.tintColor = UIColor.red
        }
    }
    
    var schedulers = [Schedule]()
    
    @IBOutlet weak var tableSchedulers: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DB.addSchedule(item: Schedule(description: "Tomar remédio", dateTime: Date(), active: true, repeatSchedule: RepeatSchedule.EveryYear, situation: Situation.Done))
        DB.addSchedule(item: Schedule(description: "Tomar água", dateTime: Date(), active: true, repeatSchedule: RepeatSchedule.EveryMonth, situation: Situation.Pending))
        DB.addSchedule(item: Schedule(description: "Almoçar", dateTime: Date(), active: false, repeatSchedule: RepeatSchedule.EveryDay, situation: Situation.Done))

        self.tableSchedulers.delegate = self
        self.tableSchedulers.dataSource = self
        self.searchBar.delegate = self
        self.tableSchedulers.setEditing(true, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let schedule = schedulers[indexPath.row]
            DB.removeSchedule(id: schedule.id)
            schedulers.remove(at: indexPath.row)
            self.tableSchedulers.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        DB.scheduleEditing = nil
        self.schedulers = DB.getAllSchedules()
        self.tableSchedulers.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.schedulers = DB.getAllSchedules()
        }
        else {
            self.schedulers = DB.filterSchedules(description: searchText)
        }
        self.tableSchedulers.reloadData()
    }
}
