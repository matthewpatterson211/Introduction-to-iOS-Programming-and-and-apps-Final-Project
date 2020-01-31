//
//  CreationViewController.swift
//  test2
//
//  Created by Matthew Patterson on 7/30/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit

protocol AdventureViewControllerDelegate {
    func charPassed(hero: Hero)
}
class AdventureViewController: UIViewController {

    
    var delegate: AdventureViewControllerDelegate?
    var name: String = ""
    var hero: Hero = Hero(name: "default", birthDay: Date(), characterClass: 0)
    var model: GameModel!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var returnHome: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()



        
        model?.adventure(adventureType: AdventureType.forest)
        self.nameLabel.text = String(model.adventureText)
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func returnHomeTapped(_ sender: Any) {
        model.hero.currentHP = model.hero.maximumHP
        model.hero.currentMP = model.hero.maximumMP
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(hero)
        if (model.returnFromBattle) == true {
            model.returningFromBattle()
            self.returnHome.setTitle("Return Home", for: .normal)
        }
        if model.hero.currentHP <= 0 {
            model.hero.currentHP = model.hero.maximumHP
            performSegue(withIdentifier: "homeSegue", sender: nil)
        }
        updateState()
          }
    
    override func viewWillAppear(_ animated: Bool) {
        updateState()
    }
    

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            



            if let nextViewController = segue.destination as? BattleViewController {
            nextViewController.model = model
            }
            
            if let nextViewController = segue.destination as? MenuViewController {
                nextViewController.model = model
            }
            
            
        }
    private func updateState() {
        
        
        nameLabel?.text = String(model.adventureText)

        
        
        
    }
    
}

extension AdventureViewController: GameModelDelegate {
    func saveCharacter(hero: Hero) {
        
    }
    
        
        func getCharacter(data: Hero) {
            hero = data
            print("test")
            print(data)
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


