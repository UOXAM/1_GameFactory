//
//  Character.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

class Character{
    
    let activity: String
    var name:String = ""
    var weapon: Weapon
    let health: Int
    var actualHealth:Int
    let heal: Int
    var nbAttack = 0
    var nbHeal = 0
    
    init(activity: String, health: Int, weapon: Weapon, heal: Int) {
        self.activity = activity
        self.health = health
        self.weapon = weapon
        self.actualHealth = health
        self.heal = heal
    }
    
    // DONNER LES INFORMATIONS PRINCIPALES D'UN PERSONNAGE
    func present(){
        print("Nom : \(name) \(activity) Vie : \(actualHealth)/\(health) Arme : \(weapon) Capacité de soin : \(heal)")
    }
    
    // ATTAQUER UN ENNEMI
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

    // SOIGNER UN MEMBRE DE MON 2QUIPE
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


        
//        teamMate.actualHealth = min(teamMate.health, teamMate.actualHealth += self.heal)

    }
    
    func openChest(){
        
    }
    
}
