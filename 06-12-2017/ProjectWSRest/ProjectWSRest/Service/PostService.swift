//
//  PostService.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//


import Foundation
import EasyRest


class PostService: Service<PostRoute> {
    
    override var base: String { return AppConfig.kHttpEndpoint }
    
    override var interceptors : [Interceptor]? {
        return [AuthInterceptor()]
    }
    
    func getPosts(onSuccess: @escaping (Response<[Post]>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.getPosts, type: [Post].self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    
}


