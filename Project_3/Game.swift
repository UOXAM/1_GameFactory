//
//  Game.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

class Game{
    var weaponsList: [Weapon] = []
    var charactersList: [Character] = []
    var charactersListToChoose: [Character] = []
    var playerOne = Player(name: "1")
    var playerTwo = Player(name: "2")
    var playGame: Bool = false
    var proposeChest: Bool = false
    var newWeapon: Weapon
    
    
    //  Création des différentes armes et personnages
    init(){
        let knife = Weapon(name: "un scalpel", damages: 25)
        weaponsList.append(knife)
        let sword = Weapon(name: "une épée", damages: 35)
        weaponsList.append(sword)
        let magicSword = Weapon(name: "l'épée Escalibur", damages: 70)
        weaponsList.append(magicSword)
        let baseballBat = Weapon(name: "une batte de Baseball", damages: 25)
        weaponsList.append(baseballBat)
        let bottle = Weapon(name: "une bouteille en verre", damages: 20)
        weaponsList.append(bottle)
        let fire = Weapon(name: "un lance-flammes", damages: 50)
        weaponsList.append(fire)
        let wood = Weapon(name: "un bâton", damages: 20)
        weaponsList.append(wood)
        let butter = Weapon(name: "un couteau à beurre", damages: 5)
        weaponsList.append(butter)
        let shuriken = Weapon(name: "un shuriken", damages: 15)
        weaponsList.append(shuriken)
        let flowers = Weapon(name: "un bouquet de fleurs", damages: 0)
        weaponsList.append(flowers)
        let flashball = Weapon(name: "un flashball", damages: 30)
        weaponsList.append(flashball)
        let bow = Weapon(name: "un arc", damages: 40)
        weaponsList.append(bow)
        let gun = Weapon(name: "un pistolet", damages: 50)
        weaponsList.append(gun)
        let magicWand = Weapon(name: "une baguette magique", damages: 55)
        weaponsList.append(gun)
        
        let policeMan = Character(activity: "le Policier", health: 150, weapon: flashball, heal: 25)
        charactersList.append(policeMan)
        let doctor = Character(activity: "le Docteur", health: 100, weapon: knife, heal: 60)
        charactersList.append(doctor)
        let military = Character(activity: "le militaire", health: 170, weapon: gun, heal: 20)
        charactersList.append(military)
        let ninja = Character(activity: "la ninja", health: 130, weapon: shuriken, heal: 30)
        charactersList.append(ninja)
        let punk = Character(activity: "le punk", health: 120, weapon: bottle, heal: 20)
        charactersList.append(punk)
        let scientist = Character(activity: "la scientifique", health: 100, weapon: fire, heal: 35)
        charactersList.append(scientist)
        let athletic = Character(activity: "le sportif", health: 150, weapon: baseballBat, heal: 20)
        charactersList.append(athletic)
        let swat = Character(activity: "le GIGN", health: 150, weapon: gun, heal: 30)
        charactersList.append(swat)
        let horseman = Character(activity: "le chevalier", health: 170, weapon: sword, heal: 10)
        charactersList.append(horseman)
        let witch = Character(activity: "la sorcière", health: 90, weapon: magicWand, heal: 55)
        charactersList.append(witch)
        self.newWeapon = knife
    }
    
    
    //  Donner un nom pour chacun des deux joueurs
    func namePlayers(){
        print("Joueur 1 : veillez saisir votre nom")
        if let namePlayerOne = readLine(){
            playerOne.name = namePlayerOne
            print("Joueur 2 : veillez saisir votre nom")
        }
        
        if let namePlayerTwo = readLine(){
            playerTwo.name = namePlayerTwo
        }
    }
    
    // Créer son équipe de 3 personnages
    func createTeam(_ player: Player){
        player.team = []
        charactersListToChoose = charactersList
        
        // Proposer d'ajouter un personnage tant qu'on en a pas 3
        while player.team.count != 3{
            
            // Afficher la liste des personnages disponibles
            showCharacters(list: charactersListToChoose)
            print("\(player.name) : choisissez le personnage \(player.team.count + 1) / 3 pour votre équipe en tapant son numéro.")
            
            //  Entrer le numéro du personnage choisi
            if let choice = readLine(){
                let choiceMember = Int(choice)!
                switch choiceMember {
                case 0..<charactersListToChoose.count :
                    
                    //  Lui donner un nom unique
                    func nameCharacter(){
                        print("Veuillez lui donner un nom.")
                        if let name = readLine(){
                            for member in player.team {
                                if name == member.name{
                                    print("Veuillez lui donner un nom différent des autres membres de votre équipe.")
                                    nameCharacter()
                                }else{
                                    charactersListToChoose[choiceMember].name = name
                                    player.team.append(charactersListToChoose[choiceMember])
                                    print("Vous venez d'ajouter \(charactersListToChoose[choiceMember].name) à votre équipe.")
                                    charactersListToChoose.remove(at: choiceMember)
                                }
                            }
                        }
                    }
                case  charactersListToChoose.count... :
                    print("Je ne reconnais pas ce personnage.")
                default :
                    print("Je ne comprends pas !")
                }
            }
        }
        
        
        
        
        //  Afficher l'équipe au complet
        showCharacters(list: player.team)
        
        //  calculer les stats de l'équipe
        player.calculateTeamStats()
    }
    
    //  Montrer le coffre (1 chance sur 4 qu'il apparaisse)
    func showChest() -> Bool{
        let x = Int.random(in: 0..<4)
        if x != 1{
            proposeChest = true
        }else{
            proposeChest = false
        }
        return proposeChest
    }
    
    //  Proposer une arme au hasard
    func randomWeapon() -> Weapon{
        let x = Int.random(in: 0..<4)
        newWeapon = weaponsList[x]
        return newWeapon
    }
    
    //  Afficher les stats de la partie
    func showStats() {
        var winner: Player
        var looser: Player
        
        playerOne.calculateTeamStats()
        playerTwo.calculateTeamStats()

        if playerOne.teamActualHealth > playerTwo.teamActualHealth {
            winner = playerOne
            looser = playerTwo
        }else{
            winner = playerTwo
            looser = playerOne
        }
        winner.nbVictory += 1
        print("Le vainqueur est \(winner.name) !")
        print("Points de vie de l'équipe : \(winner.teamActualHealth) / \(winner.teamInitialHealth)")
        print("Nombres d'attaques portées : \(winner.teamNbAttack)")
        print("Nombres de soins donnés : \(winner.teamNbHeal)")
        print("\(winner.team)")
   
        print("\(looser.name) s'est fait terrassé !")
        print("Points de vie de l'équipe : \(looser.teamActualHealth) / \(looser.teamInitialHealth)")
        print("Nombres d'attaques portées : \(looser.teamNbAttack)")
        print("Nombres de soins donnés : \(looser.teamNbHeal)")
        print("\(looser.team)")
        
        print("Nombre de parties gagnées par \(winner.name) : \(winner.nbVictory)")
        print("Nombre de parties gagnées par \(looser.name) : \(looser.nbVictory)")
    }
    
    //  Afficher les personnages d'une liste
    func showCharacters(list: [Character]){
        for character in list{
            print("Personnage n°\(list.firstIndex{$0 === character})")
            character.present()
        }
    }
    
    //  Afficher les personnages vivants d'une liste
    func showAliveCharacters(list: [Character]){
        for character in list where character.actualHealth > 0{
            print("Personnage n°\(list.firstIndex{$0 === character})")
            character.present()
        }
    }
                
    //  Proposer de jouer une partie
    func askToPlay(){
        while playGame == false {

            if let response = readLine(){
                if response == "oui"{
                    playGame = true
                }else if response == "non"{
                    print("Dommage... Vous êtes sûr... Voulez-vous jouer ? oui ou non ?")
                    
                }else{
                    print("Je ne comprends pas votre réponse")
                }
            }
        }
    }
    
    var activeCharacter: Character

    
    // Sélectionner le personnage qui va exécuter une action
    func selectCharacterOfMyTeam(_ player: Player) -> Character{
        
        //  Afficher les personnages vivants de ma team []
        showAliveCharacters(list: player.team)
        
        var choiceMember = -1
        
        //  Choisir le personnage qui va réaliser l'action
        while choiceMember < 0 || choiceMember >= player.team.count || player.team[choiceMember].actualHealth <= 0{
            print("\(player.name) : choisissez le membre de votre équipe qui va réaliser l'action, en tapant son numéro.")
            if let choice = readLine(){
                choiceMember = Int(choice)!
            }
            if choiceMember < 0 || choiceMember >= player.team.count || player.team[choiceMember].actualHealth <= 0{
                print("Je ne comprends pas, veuillez réessayer.")
            }
        }
        activeCharacter = player.team[choiceMember]
        return activeCharacter
    }
}
