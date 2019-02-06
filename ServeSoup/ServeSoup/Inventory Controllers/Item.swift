//
//  Item.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Item: Equatable, Codable {
    var categoryID: Int
    var id: Int
    var name: String
    var amount: Int
    var unit: String
    var imageURL: URL?
    
    
    init(categoryID: Int, name: String, amount: Int, unit: String = "undefined") {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.categoryID = categoryID
        self.id = 0
        self.imageURL = URL(string: "https://www.google.com/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwiA9PSk1qXgAhUT2VQKHcExDbAQjRx6BAgBEAU&url=https%3A%2F%2Ficons8.com%2F&psig=AOvVaw16fTVvDjRmJxkJIR7H9CKJ&ust=1549493242246052")
    }
    
}

struct UpperLevel: Codable, Equatable {
    let items: [Item]
}

struct identifier: Codable, Equatable {
    var id: Int
    
}
