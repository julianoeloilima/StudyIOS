//
//  Post.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 06/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest
import Genome


class Task: BaseModel {
    
    var id: String?
    var expirationDate: String?
    var title: String?
    var taskDescription: String?
    var isComplete: Bool?
    var owner : String?
    
    convenience init(id : String?, expirationDate : String?, title: String?, taskDescription : String?, isComplete : Bool?, owner : String?) {
        self.init()
        self.id = id
        self.expirationDate = expirationDate
        self.title = title
        self.taskDescription = taskDescription
        self.isComplete = isComplete
        self.owner = owner
    }
    
    override func sequence(_ map: Map) throws {
        try id <~> map["id"]
        try expirationDate <~> map["expiration_date"]
        try title <~> map["title"]
        try taskDescription <~> map["description"]
        try isComplete <~> map["is_complete"]
        try owner <~> map["owner"]
    }

}
