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
        var name:String = ""
        var weapon = Weapon()
        var health: Int
        var actualHealth: Int
        var heal: Int
        var nbAttack = 0
        var nbHeal = 0
        
        init() {
            self.activity = "Monsieur tout le monde"
            self.health = 100
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
        print("\(name) attaque avec \(weapon) et inflige \(weapon.damages) points de dégâts !")
        enemy.actualHealth -= self.weapon.damages
        if enemy.actualHealth <= 0 {
            enemy.actualHealth = 0
            print("\(enemy.name) est vaincu et rejoint les enfers !")
        }else if enemy.actualHealth == 1{
            print("\(enemy.name) tient le choc avec un dernier point de vie.")
        }else{
            print("\(enemy.name) tient le choc avec encore \(enemy.actualHealth) points de vie.")
        }
    nbAttack += 1
//        enemy.actualHealth = max(0, enemy.actualHealth -= self.weapon.damages)

    }

// SOIGNER UN MEMBRE DE MON EQUIPE ***
    func heal(teamMate: Character){
        print("\(name) apporte des soins à \(teamMate.name) !")
        teamMate.actualHealth += self.heal
        if teamMate.actualHealth >= teamMate.health{
            teamMate.actualHealth = teamMate.health
            print("\(teamMate.name) retrouve toute sa vie. Merci \(name) !")
        }else{
            print("\(teamMate.name) reprend des forces. Ses points de vie s'élèvent à présent à \(teamMate.actualHealth) / \(teamMate.health).")
        }
    nbHeal += 1
    }
}
        
//        teamMate.actualHealth = min(teamMate.health, teamMate.actualHealth += self.heal)
