import Foundation
import EasyRest


enum PostRoute: Routable {
    
    case getPosts
    
    var rule: Rule {
        switch self {
        case .getPosts:
            return Rule(method: .get, path: "/posts/",
                        isAuthenticable: false, parameters: [:])
        }
    }
    
}

