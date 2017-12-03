//
//  Schedule.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 01/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation

public enum Situation {
    case Pending
    case Done
}

public enum RepeatSchedule {
    
    case Never
    case EveryDay
    case EveryWeek
    case EveryMonth
    case EveryYear
    
    static var count : Int {
        get { return 5 }
    }
    
    static func getDescription(index : Int) -> String? {
        switch index {
        case 0: return "Única vez"
        case 1: return "Todo dia"
        case 2: return "De segunda à sexta"
        case 3: return "Todo mês"
        case 4: return "Todo ano"
        default:
            return nil
        }
    }
    
    static func getItem(index : Int) -> RepeatSchedule? {
        switch index {
        case 0: return RepeatSchedule.Never
        case 1: return RepeatSchedule.EveryDay
        case 2: return RepeatSchedule.EveryWeek
        case 3: return RepeatSchedule.EveryMonth
        case 4: return RepeatSchedule.EveryYear
        default:
            return nil
        }
    }
    
    static func getIndex(_ item : RepeatSchedule) -> Int {
        switch item {
        case RepeatSchedule.Never: return 0
        case RepeatSchedule.EveryDay: return 1
        case RepeatSchedule.EveryWeek : return 2
        case RepeatSchedule.EveryMonth: return 3
        case RepeatSchedule.EveryYear: return 4
        }
    }
}

public class Schedule {
    
    public var id : UInt
    public var description : String
    public var dateTime : Date
    public var active : Bool
    public var repeatSchedule : RepeatSchedule
    public var situation : Situation
    
    init(id : UInt, description : String, dateTime : Date, active : Bool, repeatSchedule : RepeatSchedule, situation : Situation) {
        self.id = id
        self.description = description
        self.dateTime = dateTime
        self.active = active
        self.repeatSchedule = repeatSchedule
        self.situation = situation
    }

    convenience init(description : String, dateTime : Date, active : Bool, repeatSchedule : RepeatSchedule, situation : Situation) {
        self.init(id: 0, description: description, dateTime: dateTime, active: active, repeatSchedule: repeatSchedule, situation: situation)
    }

    //the "M/d/yy, H:mm" is put together from the Symbol Table

    
    var repeatDescription : String {
        let dateFormatter = DateFormatter()
        switch self.repeatSchedule {
        case .EveryDay:
            dateFormatter.dateFormat = "H:mm"
            let strDate = dateFormatter.string(from: self.dateTime)
            return "Todos os dias às \(strDate)"
        case .EveryWeek:
            dateFormatter.dateFormat = "H:mm"
            let strDate = dateFormatter.string(from: self.dateTime)
            return "De segunda a sexta às \(strDate)"
        case .EveryMonth:
            dateFormatter.dateFormat = "d"
            let strDay = dateFormatter.string(from: self.dateTime)
            dateFormatter.dateFormat = "H:mm"
            let strHour = dateFormatter.string(from: self.dateTime)
            return "Todo dia \(strDay) às \(strHour)"
        case .EveryYear:
            dateFormatter.dateFormat = "d/M"
            let strDate = dateFormatter.string(from: self.dateTime)
            dateFormatter.dateFormat = "H:mm"
            let strHour = dateFormatter.string(from: self.dateTime)
            return "Todo ano em \(strDate) às \(strHour)"
        default:
            dateFormatter.dateFormat = "d/M/yy"
            let strDate = dateFormatter.string(from: self.dateTime)
            dateFormatter.dateFormat = "H:mm"
            let strHour = dateFormatter.string(from: self.dateTime)
            return "Uma vez em \(strDate) às \(strHour)"
        }
    }
    
    func copy() -> Schedule {
        return Schedule(id : self.id, description: self.description, dateTime: self.dateTime,
                        active: self.active, repeatSchedule : self.repeatSchedule, situation : self.situation)
    }
    
}
