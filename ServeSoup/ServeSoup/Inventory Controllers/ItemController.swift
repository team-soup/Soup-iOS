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
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "PUT"
        request.addValue("\(String(describing: accessToken))", forHTTPHeaderField: "Authorization")
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode([item])
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
        
    }
    
    func post(withItem item: Item, completion: @escaping (Error?) -> Void) {
        let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken")!
        print(accessToken)
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "POST"
        request.addValue("\(String(describing: accessToken))", forHTTPHeaderField: "Authorization")
        
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode([item])
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
    
    func createItem(withName name: String, andAmount amount: Int, andCategory categoryId: Int, completion: @escaping (Error?) -> Void) {
        let item = Item(categoryID: categoryId, name: name, amount: amount)
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
        
        let accessToken: String = KeychainWrapper.standard.string(forKey: "accessToken")!
        print(accessToken)
        let myUrl = URL(string: "https://soup-kitchen-backend.herokuapp.com/api/items")
        var request = URLRequest(url: myUrl!)
        request.httpMethod = "DELETE"
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
            completion(nil)
            }.resume()
    }
    
    
    func update(withItem item: Item, andName name: String, andAmount amount: Int, completion: @escaping (Error?) -> Void) {
        guard let index = items.index(of: item) else { return }
        items[index].name = name
        items[index].amount = amount
        let updatedItem = items[index]
        
        put(withItem: updatedItem, completion: completion)
    }
    
    
}
