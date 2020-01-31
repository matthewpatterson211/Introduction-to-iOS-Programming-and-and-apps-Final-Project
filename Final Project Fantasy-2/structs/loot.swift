//
//  loot.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 8/4/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import Foundation

struct Loot: Codable {
    var name: String
    var power: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case power
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        power = try container.decode(Int.self, forKey: .power)
    }
    
    init(name: String, power: Int) {
        self.name = name
        self.power = power
}
}
