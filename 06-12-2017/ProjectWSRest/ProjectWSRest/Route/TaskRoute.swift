import Foundation
import EasyRest


enum TaskRoute: Routable {
    
    case getTasks
    case addTask(task : Task)
    case updateTask(task : Task)
    case delete(id : String)
    
    var rule: Rule {
        switch self {
            
            case .getTasks:
                return Rule(method: .get, path: "/v1/tasks/",
                            isAuthenticable: true, parameters: [:])
            
            case let .addTask(task):
                return Rule(method: .post, path: "/v1/tasks/",
                            isAuthenticable: true, parameters: [.body: task])
            
            case let .updateTask(task):
                return Rule(method: .put, path: "/v1/tasks/{id}/",
                            isAuthenticable: true,
                            parameters: [.body: task, .path: ["id": task.id]])
            
            case let .delete(id):
                return Rule(method: .delete, path: "/v1/tasks/{id}/",
                            isAuthenticable: true,
                            parameters: [.path: ["id": id]])
        }
        
    }
}


