//
//  Player.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

class Player{
    var name: String
    var team: [Character] = []
    var teamActualHealth = 0
    var teamInitialHealth = 0
    var teamNbAttack = 0
    var teamNbHeal = 0
    var nbVictory = 0
    
    init(name: String) {
        self.name = name
    }

// CHOISIR L'ACTION A REALISER (ATTAQUE OU SOIN) ***
//    func chooseAction(of activeCharacter: Character) -> Int{
//        var choiceAction = 0
//        while choiceAction != 1 && choiceAction != 2 {
//            print("Que voulez vous que \(activeCharacter.name) \(activeCharacter.activity) fasse ?")
//            print("Tapez 1 : pour attaquer un adversaire")
//            print("Tapez 2 : pour soigner un coéquipier")
//            if let choice = readLine(){
//                choiceAction = Int(choice)!
//                print("Je ne comprends pas votre choix.")
//            }
//        }
//        if choiceAction == 1{
//            print("\(activeCharacter.name) est prêt pour attaquer.")            
//
//        }else if choiceAction == 2{
//            print("\(activeCharacter.name) est prêt pour soigner.")
//        }
//        return choiceAction
//    }
        
// CALCULER LES STATISTIQUES DE L'EQUIPE ***
    func calculateTeamStats(){
        teamNbAttack = 0
        teamNbHeal = 0
        teamInitialHealth = 0
        teamActualHealth = 0
        
        for member in team{
            teamNbAttack += member.nbAttack
            teamNbHeal += member.nbHeal
            teamInitialHealth += member.health
            teamActualHealth += member.actualHealth
        }
    }
}
