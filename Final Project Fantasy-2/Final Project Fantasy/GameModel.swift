//
//  GameModel.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 7/30/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import Foundation


protocol GameModelDelegate: class {
    func saveCharacter(hero: Hero)
}

class GameModel{
    


    var birthDay = Date()
    var hero = Hero(name: "", birthDay: Date(), characterClass: 0)
    
    var monsterName = ""
    var monsterMinAttack = 1
    var monsterMaxAttack = 2
    var monsterExperience = 5
    var monsterGold = 4
    
    var areYouOnTheMagicMenu = false
    var areYouOnTheShopMenu = false
    var areYouOnTheInventoryMenu = false
    
    var returnFromBattle = false
    
    var menuOptions = [String]()
    
    var currentAdventure = AdventureType.forest
    
    var adventureText = ""
    weak var delegate: GameModelDelegate?
    private let persistence: HeroPersistenceInterface?
   
    
    init(delegate: GameModelDelegate) {
        
        self.delegate = delegate
        let persistence = ApplicationSession.sharedInstance.persistence
        self.persistence = persistence
    }
    
    func requestData() {
        let data = hero
        print("check")
        print(data)
        
        delegate?.saveCharacter(hero: data)
    }
    

    
    
    private(set) var monsterLifeTotal = 100
    private(set) var attackDescription = ""
    
    
    
    
}

extension GameModel {
    func loadCharacter() {
        
    }
    
    func attack() {
        
        
        var heroAttack = Int.random(in: hero.minAttack ... hero.maxAttack)
        
        if hero.equipedWeapon != nil {
            heroAttack = heroAttack + hero.equipedWeapon!.power
            
            
        }
        let monsterAttack = Int.random(in: monsterMinAttack ... monsterMaxAttack)
        monsterLifeTotal -= heroAttack
        hero.currentHP -= monsterAttack
        print(hero.currentHP)

        if (monsterLifeTotal <= 0 || hero.currentHP <= 0) {
            isDead()

        }
        else{
            attackDescription = "You attack and deal \(heroAttack) damage.\n\(monsterName) attacks and deals \(monsterAttack)"
        }
    }
    
    func magicMenu() {
        areYouOnTheMagicMenu = true
        
    }
    
    func magicCast(spellType: Magic) {
        switch (spellType) {
        case .fire: if hero.currentMP >= spellType.fireCost {
            hero.currentMP -= spellType.fireCost
            let damage = (hero.magicPower * spellType.firePower + 10)
            monsterLifeTotal -= damage
            attackDescription = "\(spellType.spellText) and deal \(damage) damage"
            
        }
        else {
            attackDescription = "You don't have enough magic points. You only have \(hero.currentMP) MP"
            }
        case .ice: if hero.currentMP >= spellType.iceCost {
            hero.currentMP -= spellType.iceCost
            let damage = (hero.magicPower * spellType.icePower + 10)
            monsterLifeTotal -= damage
            attackDescription = "\(spellType.spellText) and deal \(damage) damage"
            }
        else {
            attackDescription = "You don't have enough magic points. You only have \(hero.currentMP) MP"
            }
            

            
    }
    }
    func isDead() {
        if (monsterLifeTotal <= 0) {
            
            hero.currentExperience += monsterExperience
            hero.gold += monsterGold
            attackDescription = "You win! You get \(monsterExperience) experience and \(monsterGold) gold! Current experience is \(hero.currentExperience)"
            
            print(hero)
            returnFromBattle = true
            save(hero: hero)

            
           
        }
        if (hero.currentHP <= 0) {
            attackDescription = "You lose"
            returnFromBattle = true
           
        }
       
    }
    
    func didYouLevelUp() -> (Bool) {
        if hero.currentExperience > 100 {
            return true
        }
        return false
    }
    
    func levelUP() -> (HP: Int, attack: Int, magic: Int) {
        hero.experienceLevel += 1
        hero.currentExperience -= 100
        let randomHP = Int.random(in: 1 ... 25)
        hero.maximumHP += randomHP
        let randomAttack = Int.random(in: 1 ... 20)
        hero.maxAttack += randomAttack
        hero.minAttack += randomAttack
        let randomMagic = Int.random(in: 1 ... 20)
        hero.magicPower = randomMagic
        
        return (randomHP, randomAttack, randomMagic)
        
    }
    
    func runAway() -> Bool {
        let runChance = Int.random(in: 0 ... 10)
        let monsterAttack = Int.random(in: monsterMinAttack ... monsterMaxAttack)
        hero.currentHP -= monsterAttack
        if (runChance > 8) {
            attackDescription = "You failed to escape. \(monsterName) attacks and deals \(monsterAttack)"
            return false
        }
        else {
            attackDescription = "You got out of dodge"
            return true
        }
        
    }
    
    func doYouHaveEnoughMoney(price: Int) -> Bool {
        return hero.gold>price
    }
    
    func buyIt(price: Int) {
        hero.gold -= price
    }
    
    func equipOrTrash(style: String, item: Loot)
    {
        switch style {
        case "yes":
            hero.equipedWeapon = item
            if let index = hero.equipment.firstIndex(where: { $0.name == item.name }) {
                hero.equipment.remove(at: index)
            }
        default:
            print("")
        }
    }
    

    
    func createCharacter(nameText: String?, birthDate: Date?, characterClass: Int?) -> Hero {
        
       
            let name = nameText
            
            let birthDay = birthDate
        
        let currentDate = Date()
        
        hero = Hero(name: name ?? "default", birthDay: birthDay ?? currentDate, characterClass: characterClass ?? 0)
        
        return hero
        
    }
    
    func save(hero: Hero) {
        
        persistence?.save(hero: hero)
        print("save")
        
    }
}

extension GameModel {
    func adventure(adventureType: AdventureType) {
        currentAdventure = adventureType
        
        switch (adventureType) {
        case .forest:
            let forestQuest = Int.random(in: 0 ... 1)
            if (forestQuest == 0) {
                adventureText = "It was a dark and stormy night, \(hero.name) was returning from a successful hunt when he encounter a wild kobold."
                
                monsterName = "Kobold"
                monsterLifeTotal = 100
                monsterMinAttack = 1
                monsterMaxAttack = 10
                monsterExperience = 20
                monsterGold = 5
            }
            if (forestQuest == 1) {
                adventureText = "You are wandering around the forest looking for random unlocked treasure chests. You think you saw one but it turned out to be a goblin instead"
                
                monsterName = "Goblin"
                monsterLifeTotal = 120
                monsterMinAttack = 2
                monsterMaxAttack = 12
                monsterExperience = 22
                monsterGold = 4
            }
        case .cave:
            adventureText = "You enter a dark spooky cave and encounter a giant duck"
            monsterName = "Giant Duck"
            monsterLifeTotal = 200
            monsterMinAttack = 12
            monsterMaxAttack = 22
            monsterExperience = 50
            monsterGold = 25
        case .endDungeon:
            adventureText = "You immediately encounter a giant dragon"
            monsterName = "Giant Dragon"
            monsterLifeTotal = 1000
            monsterMinAttack = 100
            monsterMaxAttack = 101
            monsterExperience = 100
            monsterGold = 1000
        }
        
    }
    func returningFromBattle() {
        adventureText = "Would you like to return home or continue exploring?"
        adventure(adventureType: currentAdventure)
    }
}



