//
//  MenuTableViewCell.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 8/4/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuOptions: UILabel!

    func setMenuText(option: String) {
        menuOptions.text = option
    }
}

class  InventoryTableViewCell: UITableViewCell {
    private(set) var loot: Loot!
    
    @IBOutlet weak var menuOptions: UILabel!
    
    @IBOutlet weak var weaponPower: UILabel!
    func setMenuText(inventoryItem: Loot) {
        self.loot = inventoryItem
        menuOptions.text = inventoryItem.name
        weaponPower.text =  String(inventoryItem.power)
    }
    
    
}
