//
//  Weapons.swift
//  Project_3
//
//  Created by ROUX Maxime on 04/02/2021.
//

import Foundation

// CATEGORIES D'ARMESD : CLASSES AYANT HERITÉES DE LA CLASSE MÈRE WEAPON

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



// ARMES : CLASSES AYANT HERITÉES DES CLASSES CATÉGORIES

class Knife: StreetWeapon {
    init(){
        super.init(name: "a knife")
    }
}

class BaseballBat: StreetWeapon {
    init(){
        super.init(name: "a baseball batt")
    }
}

class Bottle: StreetWeapon {
    init(){
        super.init(name: "a glass bottle")
    }
}

class Katana: NinjaWeapon {
    init(){
        super.init(name: "a katana")
    }
}

class Shuriken: NinjaWeapon {
    init(){
        super.init(name: "shurikens")
    }
}

class Nunchaku: StreetWeapon {
    init(){
        super.init(name: "a nunchaku")
    }
}

class MangicSword: ExtremWeapon {
    init(){
        super.init(name: "Excalibur sword")
    }
}

class FlameThrower: ExtremWeapon {
    init(){
        super.init(name: "a flamethrower")
    }
}

class MagicWand: ExtremWeapon {
    init(){
        super.init(name: "a magic wand")
    }
}

class ButterKnife: LolWeapon {
    init(){
        super.init(name: "a butter knife")
    }
}

class Flowers: LolWeapon {
    init(){
        super.init(name: "a bunch of flowers")
    }
}

class Tomatoes: LolWeapon {
    init(){
        super.init(name: "tomatoes")
    }
}

class Bow: MedievalWeapon {
    init(){
        super.init(name: "a bow with arrows")
    }
}

class Sword: MedievalWeapon {
    init(){
        super.init(name: "a sword")
    }
}

class Slingshot: MedievalWeapon {
    init(){
        super.init(name: "a slingshot")
    }
}

class Gun: FireWeapon {
    init(){
        super.init(name: "a gun")
    }
}
    
class Revolver: FireWeapon {
    init(){
        super.init(name: "a revolver")
    }
}
    
class Rifle: FireWeapon {
    init(){
        super.init(name: "a rifle")
    }
}


//        = [let knife = Knife(), let baseballBat = BaseballBat(), let bottle = Bottle(), let katana = Katana(), let shuriken = Shuriken() ,let nunchaku = Nunchaku(), let magicSword = MangicSword(), let flameThrower = Flowers(), let magicWand = MagicWand(), let Butter = ButterKnife(), let flowers = Flowers(), let tomatoes = Tomatoes(), let bow = Bow(), let sword = Sword(), let gun = Gun(), let revolver = Revolver(), let rifle = Rifle()]
