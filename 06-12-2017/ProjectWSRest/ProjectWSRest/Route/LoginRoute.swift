//
//  LoginRoute.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest

enum LoginRoute: Routable {
    
    case doLogin(userName : String, userPassword : String)
    
    var rule: Rule {
        switch self {
        case let .doLogin(userName, userPassword):

            return Rule(method: .post, path: "/oauth/token/",
                        isAuthenticable: false, parameters: [
                            .query : [
                                        "client_id" : AppConfig.ClientID,
                                        "client_secret" : AppConfig.ClientSecret,
                                        "grant_type" : "password",
                                        "username" : userName,
                                        "password" : userPassword
                                    ]
                ])
        }
    }
    
}

