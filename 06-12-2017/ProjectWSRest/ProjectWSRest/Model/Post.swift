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


class Post: BaseModel {
    
    var id: Int?
    var title: String?
    var body: String?
    
    override func sequence(_ map: Map) throws {
        try id ~> map["id"]
        try title <~> map["title"]
        try body <~> map["body"]
    }
    
}
