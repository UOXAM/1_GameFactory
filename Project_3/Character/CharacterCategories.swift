//
//  Characters.swift
//  Project_3
//
//  Created by ROUX Maxime on 04/02/2021.
//

import Foundation

let policeMan = Character(activity: "le Policier", health: 150, weapon: flashball, heal: 25)
let doctor = Character(activity: "le Docteur", health: 100, weapon: knife, heal: 60)
let military = Character(activity: "le militaire", health: 170, weapon: gun, heal: 20)
let ninja = Character(activity: "la ninja", health: 130, weapon: shuriken, heal: 30)
let punk = Character(activity: "le punk", health: 120, weapon: bottle, heal: 20)
let scientist = Character(activity: "la scientifique", health: 100, weapon: fire, heal: 35)
let athletic = Character(activity: "le sportif", health: 150, weapon: baseballBat, heal: 20)
let swat = Character(activity: "le GIGN", health: 150, weapon: gun, heal: 30)
let horseman = Character(activity: "le chevalier", health: 170, weapon: sword, heal: 10)
let witch = Character(activity: "la sorcière", health: 90, weapon: magicWand, heal: 55)

//class Character{
//
//    var activity: String
//    var name:String = ""
//    var weapon: Weapon
//    var health: Int
//    var actualHealth:Int
//    let heal: Int
//    var nbAttack = 0
//    var nbHeal = 0
//
//    init() {
//        self.activity = "Monsieur tout le monde"
//        self.health = 100
//        self.actualHealth = health
//        self.heal = 25
//    }
//}


class LawEnforcement : Character {
    init(activity: String, weapon: FireWeapon) {
        super.init()
        self.activity = activity
        self.weapon = weapon
    }
}


class AsianWarrior : Character {
    init(activity: String, weapon: NinjaWeapon) {
        super.init()
        self.activity = activity
        self.weapon = weapon
        health = 120
    }
}

class MedievalWarrior : Character {
    init(activity: String, weapon: MedievalWeapon) {
        super.init()
        self.activity = activity
        self.weapon = weapon
        health = 120
    }
}

class MedicalStaff : Character {
    init(activity: String, weapon: StreetWeapon) {
        super.init()
        self.activity = activity
        self.weapon = weapon
        health = 80
        heal = 40
    }
}

class Athlete : Character {
    init(activity: String, weapon: StreetWeapon) {
        super.init()
        self.activity = activity
        self.weapon = weapon
        health = 110
    }
}
