//
//  TaskSinc.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 11/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation

class TaskSync {
    
    let dateFormatter : DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func sync() {
        let db = TaskDB()
        let service = TaskService()
        
        service.getTasks(onSuccess: { resp in
            if resp != nil && resp!.body != nil && resp!.body!.results != nil {
                for itemServer in resp!.body!.results! {
                    if let idServer = itemServer.id {
                        let itemDB = db.selectByServerID(serverID: idServer)
                        if itemDB == nil {
                            db.insert(item: self.createTaskDB(itemServer))
                        }
                    }
                }
            }
            
            self.syncDBToService()
            
        }, onError: { error in
            
        }, always: {} )
        
    }
    
    private func syncDBToService() {
        let db = TaskDB()
        let service = TaskService()

        for item in db.selectAllWithExcludeItems() {
            syncDBToService(item: item, db: db, service: service)
        }
    }

    func syncDBToService(item : TaskEntity) {
        syncDBToService(item : item, db : TaskDB(), service : TaskService())
    }

    private func syncDBToService(item : TaskEntity, db : TaskDB, service : TaskService) {
    
        if item.syncStatus == SyncStatus.DeleteServer {
            service.delete(id: item.serverID!, onSuccess: { resp in
                item.serverID = nil
                db.update(item: item)
                db.delete(item: item.clone())
            }, onError: { _ in }, always: {  })
        }
        else if item.syncStatus == SyncStatus.AddServer || item.serverID == nil {
            service.add(task: createTaskServer(item), onSuccess: { resp in
                let itemUpdate = item.clone()
                itemUpdate.serverID = resp!.body!.id
                itemUpdate.syncStatus = SyncStatus.Syncronized
                db.update(item: itemUpdate)
            }, onError: { _ in }, always: {  })
        }
        else if item.syncStatus == SyncStatus.UpdateServer {
            service.update(task: createTaskServer(item), onSuccess: { resp in
                let itemInsert = item.clone()
                itemInsert.syncStatus = SyncStatus.Syncronized
                db.update(item: itemInsert)
            }, onError: { _ in }, always: {  })
        }
    }

    
    private func createTaskServer(_ itemDB : TaskEntity) -> Task {
        return Task(id: itemDB.serverID, expirationDate: dateFormatter.string(from: itemDB.expirationDate!), title: itemDB.title, taskDescription: itemDB.taskDescription, isComplete: itemDB.isComplete, owner: itemDB.owner)
    }

    private func createTaskDB(_ itemServer : Task) -> TaskEntity {
        return TaskEntity(serverID: itemServer.id, syncStatus: SyncStatus.Syncronized, title: itemServer.title, taskDescription: itemServer.taskDescription, expirationDate: dateFormatter.date(from: itemServer.expirationDate!), isComplete: itemServer.isComplete ?? false, owner: itemServer.owner)
    }

}
