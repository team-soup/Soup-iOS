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
        self.imageURL = URL(string: "https://ibb.co/z5MGfc6")
    }
    
}

struct UpperLevel: Codable, Equatable {
    let items: [Item]
}

struct identifier: Codable, Equatable {
    var id: Int
    
}
