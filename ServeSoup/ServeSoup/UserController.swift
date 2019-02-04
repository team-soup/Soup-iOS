//
//  UserController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

class UserController {
    
    var users: [User] = []
    static var baseURL = URL(string: "http://localhost:8000/api/staff/register")!
    static var loginURL = URL(string: "http://localhost:8000/api/staff/login")!
    
    
    func register(withUser user: User, completion: @escaping (Error?) -> Void) {
        let urlJSON = UserController.baseURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(user)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            self.users.append(user)
            completion(nil)
            }.resume()
        
    }
    
    func login(withUser user: User, completion: @escaping (Error?) -> Void) {
        let urlJSON = UserController.loginURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(user)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            completion(nil)
            }.resume()
        
    }
    
    
    
    
}
