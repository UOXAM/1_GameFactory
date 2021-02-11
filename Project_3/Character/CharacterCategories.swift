//
//  Characters.swift
//  Project_3
//
//  Created by ROUX Maxime on 04/02/2021.
//

import Foundation

// LES DIFFERENTES SOUS CLASSES DE PERSONNAGES
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
