//
//  Login.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest
import Genome

class Login: BaseModel {
    
    var accessToken : String?
    var expiresIn : Int64?
    var tokenType : String?
    var scope : String?
    var refreshToken : String?
    
    override func sequence(_ map: Map) throws {
        try accessToken <~> map["access_token"]
        try expiresIn <~> map["expires_in"]
        try tokenType <~> map["token_type"]
        try scope <~> map["scope"]
        try refreshToken <~> map["refresh_token"]
    }
    
}
