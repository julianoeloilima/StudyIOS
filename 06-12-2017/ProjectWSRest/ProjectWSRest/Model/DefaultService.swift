//
//  DefaultService.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 11/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest

class DefaultService<R> : Service<R> where R : Routable {

    override var base: String { return AppConfig.kHttpEndpoint }

    override var interceptors : [Interceptor]? {
        return [AuthInterceptor()]
    }
    
}
