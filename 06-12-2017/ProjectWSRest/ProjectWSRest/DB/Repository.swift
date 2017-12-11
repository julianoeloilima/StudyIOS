//
//  Singleton.swift
//  realmsample
//
//  Created by Lucas Paim on 07/12/2017.
//  Copyright © 2017 Lucas Paim. All rights reserved.
//

import Foundation
import RealmSwift


class Repository {
    
    static let bd = try! Realm(configuration:
        Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 4,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 3) {
                    
                    migration.enumerateObjects(ofType: TaskEntity.className(), { oldObj, newObj in
                        newObj!["id"] = UUID().uuidString
                    })
                    
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
        })
    )

    
    
}
