//
//  DB.swift
//  ReminderApp
//
//  Created by Aloc SP08608 on 01/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation

public class DB {
    
    private static var schedules = [Schedule]()
    public static var scheduleEditing : Schedule?
    
    public static func addSchedule(item : Schedule) {
        item.id = getNextScheduleID()
        schedules.append(item)
    }
    
    public static func removeSchedule(id : UInt) {
        let index = getIndexScheduleByID(id: id)
        if index != -1 {
            schedules.remove(at: index)
        }
    }

    public static func updateSchedule(schedule : Schedule) {
        for item in schedules.enumerated() {
            if schedule.id == item.element.id {
                item.element.active = schedule.active
                item.element.dateTime = schedule.dateTime
                item.element.description = schedule.description
                item.element.repeatSchedule = schedule.repeatSchedule
                item.element.situation = schedule.situation
                break
            }
        }
    }

    private static func getIndexScheduleByID(id : UInt) -> Int {
        for item in schedules.enumerated() {
            if id == item.element.id {
                return item.offset
            }
        }
        return -1
    }

    private static func getNextScheduleID() -> UInt {
        var next : UInt = 0
        for item in schedules.enumerated() {
            if next < item.element.id {
                next = item.element.id
            }
        }
        return (next + 1)
    }

    public static func getAllSchedules() -> [Schedule] {
        var newItems = [Schedule]()
        for item in schedules.enumerated() {
            newItems.append(item.element.copy())
        }
        return newItems
    }
    
    public static func filterSchedules(description : String) -> [Schedule] {
        var newItems = [Schedule]()
        for item in schedules.enumerated() {
            if item.element.description.uppercased().contains(description.uppercased()) {
                newItems.append(item.element.copy())
            }
        }
        return newItems
    }
    
}
