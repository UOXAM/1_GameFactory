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

        

    
    //
    func chooseAction(){
        print("Que voulez vous que votre personnage fasse ? Attaquer un adversaire ou soigner un membre de son équipe ?")
        
//        Si attaquer :
//        Proposer la liste des personnages adverses vivants
        print("Qui voulez vous attaquer ?")
//        activeCharacter.attack(enemy: )
        
        
//        Si soigner :
//        Proposer la liste des personnages de mon équipe vivants différents de activeCharacter
        print("Qui voulez vous soigner ?")
//        activeCharacter.heal(teamMate: )
    }
    
    func calculateTeamStats(){
        for member in team{
            teamNbAttack += member.nbAttack
            teamNbHeal += member.nbHeal
            teamInitialHealth += member.health
            teamActualHealth += member.actualHealth
        }
    }
}
