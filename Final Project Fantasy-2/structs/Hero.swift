//
//  Hero.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 7/30/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import Foundation

struct Hero: Codable {
    let id: UUID
    var name: String
    var birthDay: Date
    var characterClass: Int
    var experienceLevel: Int
    var currentExperience: Int
    var currentHP: Int
    var maximumHP: Int
    var maximumMP: Int
    var currentMP: Int
    var maxAttack: Int
    var minAttack: Int
    var magicPower: Int
    var gold: Int
    var equipedWeapon: Loot?
    var equipment: [Loot]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case birthDay = "birth day"
        case characterClass = "character class"
        case experienceLevel = "experience level"
        case currentExperience = "current experience"
        case currentHP = "current HP"
        case maximumHP = "maximum HP"
        case maximumMP = "maximum MP"
        case currentMP = "current MP"
        case maxAttack = "max attack"
        case minAttack = "min attack"
        case magicPower = "magic power"
        case gold
        case equipedWeapon = "equipped weapon"
        case equipment
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        birthDay = try container.decode(Date.self, forKey: .birthDay)
        characterClass = try container.decode(Int.self, forKey: .characterClass)
        experienceLevel = try container.decode(Int.self, forKey: .experienceLevel)
        currentExperience = try container.decode(Int.self, forKey: .currentExperience)
        currentHP = try container.decode(Int.self, forKey: .currentHP)
        maximumHP = try container.decode(Int.self, forKey: .maximumHP)
        maximumMP = try container.decode(Int.self, forKey: .maximumMP)
        currentMP = try container.decode(Int.self, forKey: .currentHP)
        maxAttack = try container.decode(Int.self, forKey: .maxAttack)
        minAttack = try container.decode(Int.self, forKey: .minAttack)
        magicPower = try container.decode(Int.self, forKey: .magicPower)
        gold = try container.decode(Int.self, forKey: .gold)
        equipedWeapon = try container.decode(Loot.self, forKey: .equipedWeapon)
        equipment = try container.decode([Loot].self, forKey: .equipment)
        
        
    }
    
    init(name: String, birthDay: Date, characterClass: Int) {
        id = UUID()
        self.name = name
        self.birthDay = birthDay
        self.characterClass = characterClass
        experienceLevel = 1
        currentExperience = 0
        currentHP = 100
        maximumHP = 100
        if (characterClass == 0) {
            maxAttack = 15
            minAttack = 10
        }
        else {
            maxAttack = 10
            minAttack = 5
        }
        if (characterClass == 1) {
            magicPower = 5
            maximumMP = 20
            currentMP = 20
        }
        else {
        magicPower = 1
        maximumMP = 10
        currentMP = 10
        }
        gold = 1000
        equipedWeapon = nil
        equipment = []
    }
}

