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
        case 0: return "Nunca"
        case 1: return "Todo dia"
        case 2: return "Toda semana"
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

    var repeatDescription : String {
        switch self.repeatSchedule {
        case .EveryDay:
            return "Todos os dias às \(self.dateTime)"
        case .EveryWeek:
            return "Durante a semana \(self.dateTime) às \(self.dateTime)"
        case .EveryMonth:
            return "Todo dia \(self.dateTime) às \(self.dateTime)"
        case .EveryYear:
            return "Todo ano em \(self.dateTime)"
        default:
            return "Uma única vez"
        }
    }
    
    func copy() -> Schedule {
        return Schedule(id : self.id, description: self.description, dateTime: self.dateTime,
                        active: self.active, repeatSchedule : self.repeatSchedule, situation : self.situation)
    }
    
}
