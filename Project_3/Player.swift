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
        
// CALCULATE THE STATS OF THE TEAM (FUNCTION USED IN THE GAME CLASS)
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
