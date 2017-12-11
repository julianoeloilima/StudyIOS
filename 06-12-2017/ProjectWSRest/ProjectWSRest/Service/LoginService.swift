//
//  LoginService.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest


class LoginService: Service<LoginRoute> {
    
    override var base: String { return AppConfig.kHttpEndpoint }
    
    private static var loggedUser : Login?
    
    public static func getLoggedUser() -> Login? {
        return loggedUser
    }
    
    func doLogin(userName : String, userPassword : String, onSuccess: @escaping (Response<Login>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.doLogin(userName: userName, userPassword: userPassword), type: Login.self,
                  onSuccess: { resp in
                    LoginService.loggedUser = resp?.body
                    onSuccess(resp)
                  },
                  onError: onError, always: always)
    }
    
}

