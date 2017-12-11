//
//  ResultConsult.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest
import Genome

public class ResultConsult<T> : BaseModel {
    
    var count: Int?
    var next: String?
    var previous: String?
    var results: [T]?
    
    override public func sequence(_ map: Map) throws {
        try count ~> map["count"]
        try next <~> map["next"]
        try previous <~> map["previous"]
        try results <~> map["results"]
    }
    
}


