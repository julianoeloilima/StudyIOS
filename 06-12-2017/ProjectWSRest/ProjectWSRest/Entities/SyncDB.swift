//
//  SyncDB.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 08/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import RealmSwift

/*
@objc public enum SyncStatus : Int {
    
    case AddServer
    case UpdateServer
    
}

@objc public protocol SyncDB {
    
    @objc var serverID : String? {get set}
    @objc var syncStatus : SyncStatus {get set}
    
}

*/

@objc enum SyncStatus : Int {
    
    case None
    case Syncronized
    case AddServer
    case UpdateServer
    case DeleteServer
    
}

protocol SyncDB {
    
    associatedtype MyType
    
    var id : String { get set }
    var serverID : String? { get set }
    var syncStatus : SyncStatus { get set }
    
    func clone() -> MyType
//    init(copy:Self)
    
}
