//
//  User.swift
//  ServeSoup
//
//  Created by Jocelyn Stuart on 2/4/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct User: Equatable, Codable {
    
    var name: String
    var email: String
    var password: String
    let token: String
    
    init(name: String, email: String, password: String, token: String = UUID().uuidString) {
        self.name = name
        self.email = email
        self.password = password
        self.token = token
    }
    
    
}
