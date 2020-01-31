//
//  BattleViewController.swift
//  Final Project Fantasy
//
//  Created by Matthew Patterson on 7/31/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit


class BattleViewController: UIViewController {
    
    func charPassed(hero: Hero) {
        model.hero = hero
    }


    
    
    @IBOutlet weak var heroName: UILabel?
    
    @IBOutlet weak var heroLifeTotal: UILabel!
    
    
    @IBOutlet weak var monsterName: UILabel?
    @IBOutlet weak var monsterLifeTotal: UILabel?
    
    @IBOutlet weak var attackDescription: UILabel?
    
    @IBOutlet weak var attackButton: UIButton!
    
    @IBOutlet weak var magicButton: UIButton!
    
    @IBOutlet weak var runAwayButton: UIButton!
    
    
    
    @IBAction func attackTapped(_ sender: Any) {
        if (model.returnFromBattle == true) {
            model.returnFromBattle = false
            levelup()
            navigationController?.popViewController(animated: true)
            
            
        }
        if model.areYouOnTheMagicMenu == true {
            model.magicCast(spellType: Magic.fire)
            
        }
        else {
        model.attack()
        }
        updateState()
    }
    
    @IBAction func magicTapped(_ sender: Any) {

        if (model.areYouOnTheMagicMenu == true && model.hero.experienceLevel == 2) {
            model.magicCast(spellType: Magic.ice)
        }
        model.magicMenu()
        self.attackButton.setTitle("Fireball    5mp", for: .normal)
        if model.hero.experienceLevel >= 2 {
            self.magicButton.setTitle("Ice magic    10mp", for: .normal )
        }
        else {
            self.magicButton.setTitle("", for: .normal)
        }
        self.runAwayButton.setTitle("Return to attack menu", for: .normal)
       updateState()
        
    }
    
    @IBAction func runAwayTapped(_ sender: Any) {
        if model.areYouOnTheMagicMenu == true {
            self.attackButton.setTitle("Attack", for: .normal)
            self.magicButton.setTitle("Magic", for: .normal)
            self.runAwayButton.setTitle("Runaway", for: .normal)
            model.areYouOnTheMagicMenu = false
            return
        }
        if model.returnFromBattle == true {
            model.returnFromBattle = false
            levelup()
            navigationController?.popViewController(animated: true)
            
        }
        if (model.runAway()) {
            model.returnFromBattle = true
            updateState()
            
            
        }
        else {
            updateState()
        }
    }
    
    var model: GameModel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(model.hero)
        self.heroName?.text = String(model.hero.name)
        print(model.returnFromBattle)


        
        self.heroLifeTotal?.text = String(model.hero.currentHP)
        self.monsterLifeTotal?.text = String(model.monsterLifeTotal)
        self.monsterName?.text = String(model.monsterName)
//
       

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if model.returnFromBattle == true {
            model.returnFromBattle = false
        }
        
    }
    
    private func updateState() {
        

        monsterLifeTotal?.text = String(model.monsterLifeTotal)
        heroLifeTotal?.text = String(model.hero.currentHP)
        attackDescription?.text = String(model.attackDescription)

        
        
    }
    
    private func levelup() {
        if (model.didYouLevelUp()) {
            let results = model.levelUP()
            let alert = UIAlertController(title: "You leveled Up!", message: "Your HP increased by \(results.HP), your attack increased by \(results.attack), your magic increased by \(results.magic)", preferredStyle: .actionSheet)
            
            if model.hero.experienceLevel == 2 {
                alert.addAction(UIAlertAction(title: "Wow I learned Ice Magic", style: .default, handler: nil))
            }
            else {
                alert.addAction(UIAlertAction(title: "Sweet", style: .default, handler: nil))
                
            }
            

            
            self.present(alert, animated: true)
            
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        if let nextViewController = segue.destination as? BattleViewController {
            nextViewController.model = model
        }
        if let nextViewController = segue.destination as? MenuViewController {
            nextViewController.model = model
        }
    
    }
    /*
     // MARK: - Navigation
     
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

