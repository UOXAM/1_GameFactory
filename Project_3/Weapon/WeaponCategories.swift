//
//  Weapons.swift
//  Project_3
//
//  Created by ROUX Maxime on 04/02/2021.
//

import Foundation

// CLASSES D'ARMES AYANT HERITÉES DE LA CLASSE MÈRE WEAPON

class FireWeapon : Weapon {
    init(name: String) {
        super.init()
        self.name = name
        damages = 45
    }
}

class NinjaWeapon : Weapon {
    init(name: String) {
        super.init()
        self.name = name
        damages = 35
    }
}

class StreetWeapon : Weapon {
    init(name: String) {
        super.init()
        self.name = name
        damages = 25
    }
}

class ExtremWeapon : Weapon {
    init(name: String) {
        super.init()
        self.name = name
        damages = 60
    }
}

class LolWeapon : Weapon {
    init(name: String) {
        super.init()
        self.name = name
        damages = 5
    }
}

class MedievalWeapon : Weapon {
    init(name: String) {
        super.init()
        self.name = name
        damages = 35
    }
}
