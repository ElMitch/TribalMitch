//
//  Endpoint.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import UIKit
import Alamofire

final class Endpoint {
    
    static let base: String = "https://api.unsplash.com/"
    static let accessKey = "7rJ07w74jwLCxA0sezm8JFea55MCSjCjp5tQeZ7fRvM"
    
    enum Action: String {
        case photos = "photos"
        case profile = "users"
        case collections = "collections"
    }
    
    static func with(action: Action) -> String {
        let url = "\(base)\(action.rawValue)?client_id=\(accessKey)"
        debugPrint(url)
        return url
    }
    
    static func with(action: Action, param: String) -> String {
        let url = "\(base)\(action.rawValue)/\(param)?client_id=\(accessKey)"
        debugPrint(url)
        return url
    }
    
    static func with(firstAction: Action, secondAction: Action, param: String) -> String {
        let url = "\(base)\(firstAction.rawValue)/\(param)/\(secondAction.rawValue)?client_id=\(accessKey)"
        debugPrint(url)
        return url
    }
}
