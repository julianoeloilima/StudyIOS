//
//  SaveSchedule.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 01/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import UIKit

class SaveScheduleController: UIViewController,
    UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var txfDescription: UITextField!
    @IBOutlet weak var dtpDateTime: UIDatePicker!
    @IBOutlet weak var swtActive: UISwitch!
    @IBOutlet weak var pkvRepeat: UIPickerView!
    @IBOutlet weak var btnSave: UIButton!
    
    // PICKERVIEW
    
    var selectionRepeat : RepeatSchedule = RepeatSchedule.Never
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RepeatSchedule.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return RepeatSchedule.getDescription(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectionRepeat = RepeatSchedule.getItem(index: row)!
    }
    
    // FIM DO PICKERVIEW

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    @IBAction func closeKeyboard(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        if txfDescription.text != nil {
            if let scEdit = DB.scheduleEditing {
                scEdit.description = txfDescription.text!
                scEdit.dateTime = dtpDateTime.date
                scEdit.active = swtActive.isOn
                scEdit.repeatSchedule = selectionRepeat
                DB.updateSchedule(schedule: scEdit)
                showMsg(title: "Sucesso", msg: "Lembrete atualizado.")
                DB.scheduleEditing = nil
            }
            else {
                let schedule = Schedule(description: txfDescription.text!, dateTime: dtpDateTime.date, active: swtActive.isOn, repeatSchedule: selectionRepeat, situation : Situation.Pending)
                DB.addSchedule(item: schedule)
                showMsg(title: "Sucesso", msg: "Lembrete criado.")
            }
        }
        else {
            showMsg(title: "Atenção", msg: "Informe a descrição.")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pkvRepeat.delegate = self
        self.pkvRepeat.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        if let scEdit = DB.scheduleEditing {
            txfDescription.text = scEdit.description
            dtpDateTime.date = scEdit.dateTime
            swtActive.isOn = scEdit.active
            selectionRepeat = scEdit.repeatSchedule
            pkvRepeat.selectRow(RepeatSchedule.getIndex(selectionRepeat), inComponent: 0, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
