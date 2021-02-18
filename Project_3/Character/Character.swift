//
//  Character.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation
    
//  ****************************************************
//                   CLASS CHARACTER
//  ****************************************************

class Character{
        
        var activity: String
        var name: String = ""
        var weapon = Weapon()
        var health: Int
        var actualHealth: Int
        var heal: Int
        var nbAttack = 0
        var nbHeal = 0
        
        init() {
            self.activity = "Man on the street"
            self.health = 70
            self.actualHealth = health
            self.heal = 25
        }
    
// ATTACK AN ENEMY (FUNCTION USED IN THE CLASS GAME)
    func attack(enemy: Character){
        print("\n\(name) attacks with \(weapon.name) and causes \(weapon.damages) points of damage !")
        enemy.actualHealth -= self.weapon.damages
        if enemy.actualHealth <= 0 {
            enemy.actualHealth = 0
            print("\n\(enemy.name) is killed and go to hell !\n")
        }else if enemy.actualHealth == 1{
            print("\n\(enemy.name) stays alive with 1 point of health.\n")
        }else{
            print("\n\(enemy.name) stays alive with \(enemy.actualHealth) points of health.\n")
        }
    }

// HEAL A MEMBER OF MY TEAM (FUNCTION USED IN THE CLASS GAME)
    func heal(teamMate: Character){
        if name == teamMate.name{
            print("\n\(name) give health to himself !")
        }else{
            print("\n\(name) give health to \(teamMate.name) !")
        }
        teamMate.actualHealth += self.heal
        if teamMate.actualHealth >= teamMate.health{
            teamMate.actualHealth = teamMate.health
            print("\(teamMate.name) is in full health !")
        }else{
            print("\(teamMate.name) fell better with \(teamMate.actualHealth) / \(teamMate.health) points of health.")
        }
    }
}
