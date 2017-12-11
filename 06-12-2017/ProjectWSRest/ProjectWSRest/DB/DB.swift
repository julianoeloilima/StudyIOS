//
//  DB.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 08/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import RealmSwift

class DB<T> where T : SyncDB, T : Object {
    
    public func selectAll() -> [T] {
        var items = [T]()
        Repository.bd.objects(T.self).forEach {
            if $0.syncStatus != SyncStatus.DeleteServer {
                items.append($0.clone() as! T)
            }
        }
        return items
    }
    
    public func selectAllWithExcludeItems() -> [T] {
        var items = [T]()
        Repository.bd.objects(T.self).forEach {
            if $0.syncStatus != SyncStatus.DeleteServer {
                items.append($0.clone() as! T)
            }
        }
        return items
    }

    
    public func selectByServerID(serverID : String) -> T? {
        let item = Repository.bd.objects(T.self).filter(NSPredicate(format: "serverID = %@", serverID)).first
        if item != nil {
            return item?.clone() as? T
        }
        return nil
    }

    public func selectByID(id : String) -> T? {
        let item = Repository.bd.objects(T.self).filter(NSPredicate(format: "id = %@", id)).first
        if item != nil {
            return item?.clone() as? T
        }
        return nil
    }

    public func insert(item : T) {
        try! Repository.bd.write {
            Repository.bd.add(item)
        }
    }

    public func update(item : T) {
        try! Repository.bd.write {
            Repository.bd.add(item, update: true)
        }
    }
    
    public func update(update: () -> Void) {
        try! Repository.bd.write {
            update()
        }
    }

    /*
    public func update(update: () -> Void) {
        try! Repository.bd.write {
            update()
        }
    }
 */

    
    public func delete(item : T) {
        try! Repository.bd.write {
            var del = Repository.bd.objects(T.self).filter(NSPredicate(format: "id = %@", item.id)).first
            if del != nil {
                if del!.serverID == nil {
                    Repository.bd.delete(del!)
                }
                else {
                    del!.syncStatus = SyncStatus.DeleteServer
                    Repository.bd.add(del!, update: true)
                }
            }
        }
    }

    public func delete(items : [T]) {
        try! Repository.bd.write {
            Repository.bd.delete(items)
        }
    }

}

