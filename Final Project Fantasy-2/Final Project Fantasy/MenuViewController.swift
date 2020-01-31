//
//  MenuViewController.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 8/4/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit
import Foundation


class MenuViewController: UIViewController {
    
    func charPassed(hero: Hero) {
        model.hero = hero
    }
    
    var model: GameModel!
    
    var menuOptions = ["", Loot.self] as [Any]

    var shopitems: [Loot] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(model.hero)
        menuOptions = createMenuArray()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }


func createMenuArray() -> [String] {
    let options = ["Go to shop", "Explore Forest", "Explore a cave", "Explore evil final end dungeon", "Inventory"]
    
    return options
}
    
    func createShopArray() -> [String] {
        let options = ["Bamboo Pole     2 power     10 gold", "Club     4 power     60 gold", "Final Endgame Sword     100 power    1800 gold", "Exit Shop"]
        return options
    }
    func createInventoryArray() -> [Loot] {
        
        let options = model.hero.equipment
        return options
    }
    func boughtIt() {
        let alert = UIAlertController(title: "You bought it!", message: "You have \(model.hero.gold) gold remaining", preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Nice!", style: .default, handler: nil))
        self.present(alert, animated: true)
        
    }
    func equipOrTrash (item: Loot) {
        let alert = UIAlertController(title: "Would you like to equip \(item.name)", message: "It's power is \(item.power)", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Yes!", style: .default, handler:
            {action in
                self.model.equipOrTrash(style: "yes", item: item)}))
        alert.addAction(UIAlertAction(title: "No!", style: .default, handler:
            {action in
                self.model.equipOrTrash(style: "no", item: item)}))
        alert.addAction(UIAlertAction(title: "Leave inventory", style: .default, handler:
            {action in
                self.model.equipOrTrash(style: "trash", item: item)}))
        
        self.present(alert, animated: true)
        
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menuchoice = menuOptions[indexPath.row] as? String {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        
        
        cell.setMenuText(option: menuchoice)
        
        return cell
        }
        else if let inventoryChoice = menuOptions[indexPath.row] as? Loot {
            let cell = tableView.dequeueReusableCell(withIdentifier: "InventoryCell") as! InventoryTableViewCell
            cell.setMenuText(inventoryItem: inventoryChoice)
            let alert = UIAlertController(title: "Would you like to equip \(cell.loot.name)", message: "It's power is \(cell.loot.power)", preferredStyle: .alert)
            
            
                        alert.addAction(UIAlertAction(title: "Yes!", style: .default, handler:
                            {action in
                                self.model.equipOrTrash(style: "yes", item: cell.loot)}))
                        alert.addAction(UIAlertAction(title: "No!", style: .default, handler:
                            {action in
                                self.model.equipOrTrash(style: "no", item: cell.loot)}))
                        alert.addAction(UIAlertAction(title: "Leave inventory", style: .default, handler:
                            {action in
                                self.model.equipOrTrash(style: "trash", item: cell.loot)}))
            
                        self.present(alert, animated: true)
            print (inventoryChoice)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        
        //main menu
        
        if (indexPath.row == 0 && model.areYouOnTheShopMenu == false) {
            self.tableView.deselectRow(at: indexPath, animated: true)
            model.areYouOnTheShopMenu = true
            menuOptions = createShopArray()
            tableView.reloadData()
            return
        }
        
        if (indexPath.row == 1 && model.areYouOnTheShopMenu == false) {
            model.adventure(adventureType: AdventureType.forest)
            navigationController?.popViewController(animated: true)
            
        }
        
        if (indexPath.row == 2 && model.areYouOnTheShopMenu == false) {
            model.adventure(adventureType: AdventureType.cave)
            navigationController?.popViewController(animated: true)
            
        }
        
        if (indexPath.row == 3  && model.areYouOnTheShopMenu == false) {
            model.adventure(adventureType: AdventureType.endDungeon)
            navigationController?.popViewController(animated: true)
            
        }
        
        if (indexPath.row == 4  && model.areYouOnTheShopMenu == false) {
            menuOptions = createInventoryArray()
            tableView.reloadData()
            model.areYouOnTheInventoryMenu = true
            return
        }
        //shop menu
        if (indexPath.row == 0 && model.areYouOnTheShopMenu == true)
        {
            if model.doYouHaveEnoughMoney(price: 10) {
                model.buyIt(price: 10)
                let bambooPole = Loot(name: "Bamboo Pole", power: 2)
                
                model?.hero.equipment.append(bambooPole)
                boughtIt()
                }
            

            

        }
        if (indexPath.row == 1 && model.areYouOnTheShopMenu == true)
        {
            if model.doYouHaveEnoughMoney(price: 60) {
                model.buyIt(price: 60)
                let club = Loot(name: "club", power: 4)
                model.hero.equipment.append(club)
                boughtIt()
            }
            
            
        }
        if (indexPath.row == 2 && model.areYouOnTheShopMenu == true)
        {
            if model.doYouHaveEnoughMoney(price: 1800) {
                model.buyIt(price: 1800)
                let endgameSword = Loot(name: "Final Endgame Sword", power: 100)
                model.hero.equipment.append(endgameSword)
                
                boughtIt()
            }
        
            
        }
        if (indexPath.row == 3 && model.areYouOnTheShopMenu == true)
        {
            model.areYouOnTheShopMenu = false
            menuOptions = createMenuArray()
            self.tableView.deselectRow(at: indexPath, animated: true)
            tableView.reloadData()
        }
        

//        if model.areYouOnTheInventoryMenu == true {
//            model.areYouOnTheInventoryMenu = false
//            let cell = tableView.cellForRow(at: indexPath) as! InventoryTableViewCell
//
//            print("test")
//            let alert = UIAlertController(title: "Would you like to equip \(cell.loot.name)", message: "It's power is \(cell.loot.power)", preferredStyle: .alert)
//
//
//            alert.addAction(UIAlertAction(title: "Yes!", style: .default, handler:
//                {action in
//                    self.model.equipOrTrash(style: "yes", item: cell.loot)}))
//            alert.addAction(UIAlertAction(title: "No!", style: .default, handler:
//                {action in
//                    self.model.equipOrTrash(style: "no", item: cell.loot)}))
//            alert.addAction(UIAlertAction(title: "Leave inventory", style: .default, handler:
//                {action in
//                    self.model.equipOrTrash(style: "trash", item: cell.loot)}))
//
//            self.present(alert, animated: true)
//
//        }
    }

    


}
