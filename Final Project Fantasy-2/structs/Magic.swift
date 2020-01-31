//
//  Magic.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 8/6/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import Foundation

enum Magic : String {
    case fire = "Fireball spell"
    case ice = "Ice magic"

    var spellText: String { return "You cast \(rawValue)"}
    var fireCost: Int {return  5}
    var iceCost : Int {return 10}
    var icePower: Int {return 3}
    var firePower: Int {return 2}
}
