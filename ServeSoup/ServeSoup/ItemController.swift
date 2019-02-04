//
//  ItemController.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

class ItemController {
    
    var items: [Item] = []
    
    static var baseURL = URL(string: "http://localhost:8000/api/items")!
    
    func put(withItem item: Item, completion: @escaping (Error?) -> Void) {
        let url = ItemController.baseURL.appendingPathComponent(String(item.id))
        let urlJSON = url.appendingPathExtension("json")
        
        var urlRequest = URLRequest(url: urlJSON)
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
    
    
    
}
