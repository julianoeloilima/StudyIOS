//
//  CurlInterceptor.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import Genome
import Alamofire
import EasyRest

open class AuthInterceptor: Interceptor {
    
    required public init() {}
    
    open func requestInterceptor<T: NodeInitializable>(_ api: API<T>) {
        if let token = LoginService.getLoggedUser()?.accessToken {
            api.headers["Authorization"] = "Bearer \(token)"
        }
    }
    
    open func responseInterceptor<T: NodeInitializable>(_ api: API<T>, response: DataResponse<Any>) {

    }
    
}
