//
//  Character.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation
    
// CLASSE PERSONNAGE
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

    
// AFFICHER LES INFORMATIONS PRINCIPALES D'UN PERSONNAGE ***
    func present(){
        if name == ""{
            print("\(activity) -> Life : \(actualHealth)/\(health) - Weapon : \(weapon.name)(\(weapon.damages)) - Heal :\(heal)")
        }else{
            print("\(name), \(activity) -> Life : \(actualHealth)/\(health) - Weapon : \(weapon.name)(\(weapon.damages)) - Heal :\(heal)")
        }
    }
    
// ATTAQUER UN ENNEMI ***
    func attack(enemy: Character){
        print("\n\(name) attacks with \(weapon.name) and causes \(weapon.damages) points of damage !")
        enemy.actualHealth -= self.weapon.damages
        if enemy.actualHealth <= 0 {
            enemy.actualHealth = 0
            print("\(enemy.name) is killed and go to hell !")
        }else if enemy.actualHealth == 1{
            print("\(enemy.name) stays alive with 1 point of health.")
        }else{
            print("\(enemy.name) stays alive with \(enemy.actualHealth) points of helth.")
        }
    nbAttack += 1
//        enemy.actualHealth = max(0, enemy.actualHealth -= self.weapon.damages)

    }

// SOIGNER UN MEMBRE DE MON EQUIPE ***
    func heal(teamMate: Character){
        print("\n\(name) give health to \(teamMate.name) !")
        teamMate.actualHealth += self.heal
        if teamMate.actualHealth >= teamMate.health{
            teamMate.actualHealth = teamMate.health
            print("\(teamMate.name) is in full health. Thanks to \(name).")
        }else{
            print("\(teamMate.name) fell better with \(teamMate.actualHealth) / \(teamMate.health) points of health.")
        }
    nbHeal += 1
    }
}
        
//        teamMate.actualHealth = min(teamMate.health, teamMate.actualHealth += self.heal)
