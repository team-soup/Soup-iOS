//
//  ItemController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class ItemController {
    
    var items: [Item] = []
    
    var user: User!
    
    let userController = UserController()
    
    static var baseURL = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")!
    
    func put(withItem item: Item, completion: @escaping (Error?) -> Void) {
        let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken")!
        print(accessToken)
       // let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")!
        let newUrl = ItemController.baseURL.appendingPathComponent("\(String(describing: item.id))")
        
        var request = URLRequest(url: newUrl)
        request.httpMethod = "PUT"
        
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(String(describing: accessToken))", forHTTPHeaderField: "Authorization")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(item)
        } catch {
            print(error)
            completion(error)
            return
        }
        

        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            
            self.items.append(item)
            completion(nil)
            }.resume()
        
        
        
        
    /*    func createPostsWith(postName: String, imageUrl: String?, description: String?, completion: @escaping(Error?) -> Void){
            
            let baseURL = URL(string: "https://backend-art.herokuapp.com/api/posts")!
            
            let params = ["postName" : postName, "imageUrl": imageUrl, "description" : description]
            
            guard let body = try? JSONEncoder().encode(params) else { return }
            var request = URLRequest(url: baseURL)
            
            let userDefaults = UserDefaults.standard
            
            let authToken = userDefaults.value(forKeyPath: "token") as? String
            
            request.httpMethod = HTTPHelper.post.rawValue
            request.httpBody = body
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue(authToken, forHTTPHeaderField: "authorization")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error with the requst: \(error)")
                    completion(error)
                }
                
                if let response = response {
                    print("Response from request: \(response)")
                    completion(nil)
                }
                
                }.resume()
        }*/
        
        
    }
    
    func post(withItem item: Item, completion: @escaping (Error?) -> Void) {
        let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken")!
        print(accessToken)
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("\(String(describing: accessToken))", forHTTPHeaderField: "Authorization")
        
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(item)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { (_, _, error: Error?) in
            
            if error != nil {
                print( "Could not successfully perform this request. Please try again later")
                print("error=\(String(describing: error))")
                return
            }
            self.items.append(item)
            completion(nil)
            
            
        }
        task.resume()
        
        
    }
    
    func createItem(withName name: String, andAmount amount: Int, andCategory categoryId: Int, andUnit unit: String?, completion: @escaping (Error?) -> Void) {
        let item = Item(categoryID: categoryId, name: name, amount: amount, unit: unit ?? "undefined")
        print(item)
        post(withItem: item, completion: completion)
        
    }
    
    
    func delete(item: Item, completion: @escaping (Item?) -> Void) {
        deleteFromServer(item: item) { (error) in
            if let error = error {
                print(error)
            }
            guard let index = self.items.index(of: item) else {return}
            completion(self.items.remove(at: index))
        }
        
    }
    
    func deleteFromServer(item: Item, completion: @escaping (Error?) -> Void) {
       /* let url = ItemController.baseURL.appendingPathComponent(String(item.id))
        let urlJSON = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.addValue(KeychainWrapper.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "DELETE"*/
        //  guard let itemId = item.id else { return }
        let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken")!
        print(accessToken)
        let url = ItemController.baseURL.appendingPathComponent(String(item.id))
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(accessToken, forHTTPHeaderField: "Authorization")
        
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(item)
        } catch {
            print(error)
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print(error)
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    
    func update(withItem item: Item, andName name: String, andAmount amount: Int, completion: @escaping (Error?) -> Void) {
        guard let index = items.index(of: item) else { return }
        items[index].name = name
        items[index].amount = amount
        let updatedItem = items[index]
        print(updatedItem)
        
        put(withItem: updatedItem, completion: completion)
    }
    
    
}
