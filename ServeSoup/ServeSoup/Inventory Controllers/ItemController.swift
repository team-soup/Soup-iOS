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
        let url = ItemController.baseURL.appendingPathComponent(String(item.id))
        let urlJSON = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.addValue(KeychainWrapper.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(item)
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
            self.items.append(item)
            completion(nil)
            }.resume()
        
    }
    
    func createItem(withName name: String, andAmount amount: Int, andCategory categoryId: Int, andId id: Int, completion: @escaping (Error?) -> Void) {
        let item = Item(categoryId: categoryId, id: id, name: name, amount: amount)
        put(withItem: item, completion: completion)
        
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
        let url = ItemController.baseURL.appendingPathComponent(String(item.id))
        let urlJSON = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
        urlRequest.addValue(KeychainWrapper.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "Authorization")
        urlRequest.httpMethod = "DELETE"
        
        do {
            let encoder = JSONEncoder()
            urlRequest.httpBody = try encoder.encode(item)
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
    
    
    func update(withItem item: Item, andName name: String, andAmount amount: Int, completion: @escaping (Error?) -> Void) {
        guard let index = items.index(of: item) else { return }
        items[index].name = name
        items[index].amount = amount
        let updatedItem = items[index]
        
        put(withItem: updatedItem, completion: completion)
    }
    
    func fetchItems(completion: @escaping (Error?) -> Void) {
       /* let url = ItemController.baseURL.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(userController.finalToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            if let error = error {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let decodedDict = try jsonDecoder.decode([String: Item].self, from: data)
                let items = Array(decodedDict.values)
                self.items = items
                completion(nil)
            } catch {
                print("Error decoding received data: \(error)")
                completion(error)
                return
            }
            
            }.resume()*/
        
    }
    
   
    
}
