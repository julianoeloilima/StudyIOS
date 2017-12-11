//
//  PostService.swift
//  ProjectWSRest
//
//  Created by Aloc SP08608 on 07/12/2017.
//  Copyright © 2017 Aloc SP08608. All rights reserved.
//

import Foundation
import EasyRest


class TaskService: DefaultService<TaskRoute> {
    
    func getTasks(onSuccess: @escaping (Response<ResultConsult<Task>>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.getTasks, type: ResultConsult<Task>.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }
    
    func add(task: Task, onSuccess: @escaping (Response<Task>?) -> Void,
                  onError: @escaping (RestError?) -> Void,
                  always: @escaping () -> Void) {
        try! call(.addTask(task: task), type: Task.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }

    func update(task: Task, onSuccess: @escaping (Response<Task>?) -> Void,
             onError: @escaping (RestError?) -> Void,
             always: @escaping () -> Void) {
        try! call(.updateTask(task: task), type: Task.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }

    func delete(id: String, onSuccess: @escaping (Response<Task>?) -> Void,
                onError: @escaping (RestError?) -> Void,
                always: @escaping () -> Void) {
        try! call(.delete(id: id), type: Task.self, onSuccess: onSuccess,
                  onError: onError, always: always)
    }

}


