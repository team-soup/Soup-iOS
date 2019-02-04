//
//  Item.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Item: Equatable, Codable {
    var categoryId: Int
    var id: Int
    var name: String
    var amount: Int
    var unit: String
    
    
    init(categoryId: Int, id: Int, name: String, amount: Int, unit: String = "") {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.categoryId = categoryId
        self.id = id
    }
    
}
