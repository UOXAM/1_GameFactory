//
//  Weapon.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

class Weapon{
    let damages: Int
    let name: String
    
    init(name: String, damages: Int) {
        self.name = name
        self.damages = damages
    }
}
