//
//  TaskDB.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 08/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import RealmSwift

class TaskEntity : Object, SyncDB {
    
    convenience init(id : String, serverID : String?, syncStatus : SyncStatus, title : String?, taskDescription : String?, expirationDate : Date?, isComplete : Bool, owner : String?) {
        self.init()
        self.id = id
        self.serverID = serverID
        self.syncStatus = syncStatus
        self.title = title
        self.taskDescription = taskDescription
        self.expirationDate = expirationDate
        self.isComplete = isComplete
        self.owner = owner
    }

    convenience init(serverID : String?, syncStatus : SyncStatus, title : String?, taskDescription : String?, expirationDate : Date?, isComplete : Bool, owner : String?) {
        self.init()
        self.id = UUID().uuidString
        self.serverID = serverID
        self.syncStatus = syncStatus
        self.title = title
        self.taskDescription = taskDescription
        self.expirationDate = expirationDate
        self.isComplete = isComplete
        self.owner = owner
    }

    func clone() -> TaskEntity {
        return TaskEntity(id: self.id, serverID: self.serverID, syncStatus: self.syncStatus, title: self.title, taskDescription: self.taskDescription, expirationDate: self.expirationDate, isComplete: self.isComplete, owner: self.owner)
    }

    typealias MyType = TaskEntity
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var serverID: String?
    @objc dynamic var syncStatus: SyncStatus = SyncStatus.None
    
    @objc dynamic var title : String?
    @objc dynamic var taskDescription : String?
    @objc dynamic var expirationDate : Date?
    @objc dynamic var isComplete : Bool = false
    @objc dynamic var owner : String?

    override static func primaryKey() -> String? {
        return "id"
    }

}
