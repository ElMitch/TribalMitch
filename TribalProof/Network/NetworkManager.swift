//
//  NetworkManager.swift
//  TribalWorldWideMitch
//
//  Created by Mitch Samaniego on 23/07/21.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    
    
    func getPhotos(page: Int, completion: @escaping ([Photo]) -> Void) {
        let endpointAction = Endpoint.with(action: .photos)
        let endpointWithParams = "\(endpointAction)&page=\(page)"
        
        AF.request(endpointWithParams).responseJSON { response in
            if let error = response.error {
                debugPrint(error.localizedDescription)
                completion([])
            } else {
                let data = response.data
                let model = try! JSONDecoder().decode([Photo].self, from: data!)
                completion(model)
            }
        }
    }
    
    func getDetailsPhoto(id: String, completion: @escaping (Photo) -> Void) {
        let endpointAction = Endpoint.with(action: .photos, param: id)
        AF.request(endpointAction).responseJSON { response in
            if let error = response.error {
                debugPrint(error.localizedDescription)
            } else {
                let data = response.data
                let model = try! JSONDecoder().decode(Photo.self, from: data!)
                completion(model)
            }
        }
    }
    
    func getProfile(userName: String, completion: @escaping (User) -> Void) {
        let endpoint = Endpoint.with(action: .profile, param: userName)
        
        AF.request(endpoint).responseJSON { response in
            if let error = response.error {
                debugPrint(error.localizedDescription)
            } else {
                let data = response.data
                let model = try! JSONDecoder().decode(User.self, from: data!)
                completion(model)
            }
        }
    }
    
    func getCollections(userName: String, completion: @escaping ([Collections]) -> Void) {
        let endpoint = Endpoint.with(firstAction: .profile, secondAction: .collections, param: userName)
        
        AF.request(endpoint).responseJSON { response in
            if let error = response.error {
                debugPrint(error.localizedDescription)
            } else {
                let data = response.data
                let model = try! JSONDecoder().decode([Collections].self, from: data!)
                completion(model)
            }
        }
    }
    
}
