//
//  ViewController.swift
//  test2
//
//  Created by Matthew Patterson on 7/30/19.
//  Copyright © 2019 Matthew Patterson. All rights reserved.
//

import UIKit



class CharacterCreationViewController: UIViewController {

    func charPassed(hero: Hero) {
        model.hero = hero
    }
    

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var classSelector: UISegmentedControl!
    @IBAction func continueTapped(_ sender: Any) {
        
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var model: GameModel!
    
    private var hero: Hero = Hero(name: "default", birthDay: Date(), characterClass: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = GameModel(delegate: self)
        model.requestData()
        // Do any additional setup after loading the view.
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let name = name.text
            else { return }
         let birthday = datePicker.date
                       
        let characterClass = classSelector.selectedSegmentIndex
        print(name)
        print (birthday)
        print (characterClass)
        hero = model.createCharacter(nameText: name, birthDate: birthday, characterClass: characterClass)
        print(hero)
        if let nextViewController = segue.destination as? AdventureViewController {
            nextViewController.model = model
        }
        

        
        
    }


    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}

extension CharacterCreationViewController: GameModelDelegate {
    func saveCharacter(hero: Hero) {
        
    }
    

    
    func getCharacter(data: Hero) {
        hero = data
        print("test1")
        print(data)
    }
}

extension CharacterCreationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

