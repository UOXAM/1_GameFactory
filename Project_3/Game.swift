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
    var playerOne = Player(name: "Joueur 1")
    var playerTwo = Player(name: "Joueur 2")

//  NOMMER UN JOUEUR ***
    func namePlayer(_ player: Player) {
        while player.name == "Joueur 1" || player.name == "Joueur 2" || playerOne.name == playerTwo.name {
            print("\(player.name): veillez saisir votre nom")
            if let name = readLine(){
                player.name = name
                if playerOne.name == playerTwo.name{
                    print("Ce nom est déjà pris par l'autre joueur.")
                }
            }
        }
    }
    
    
//  PROPOSER DE JOUER UNE PARTIE ***
    func askToPlay(){
        var playGame = false
        while playGame == false {
            print("Prêt pour jouer ? Oui ou non ?")
            if let response = readLine(){
                if response.uppercased() == "OUI" || response.uppercased() == "YES"{
                    playGame = true
                }else if response.uppercased() == "NON" || response.uppercased() == "NO"{
                    print("Dommage... Vous êtes sûr... Voulez-vous jouer ? oui ou non ?")
                }else{
                    print("Je ne comprends pas votre réponse")
                }
            }
        }
        print("Parfait, commençons la partie !")
    }
    
    
// CREER LA LISTE DES ARMES ET PERSONNAGES DU JEU ***
    func initializeCharactersAndWeapons(){
        weaponsList = []
        let knife = StreetWeapon(name: "un couteau") ; weaponsList.append(knife)
        let baseballBat = StreetWeapon(name: "une batte de Baseball") ; weaponsList.append(baseballBat)
        let bottle = StreetWeapon(name: "une bouteille en verre") ; weaponsList.append(bottle)
        let katana = NinjaWeapon(name: "un katana") ; weaponsList.append(katana)
        let shuriken = NinjaWeapon(name: "des shurikens") ; weaponsList.append(shuriken)
        let nunjaku = NinjaWeapon(name: "un nunjaku)") ; weaponsList.append(nunjaku)
        let magicSword = ExtremWeapon(name: "l'épée Escalibur") ; weaponsList.append(magicSword)
        let flameThrower = ExtremWeapon(name: "un lance-flammes") ; weaponsList.append(flameThrower)
        let magicWand = ExtremWeapon(name: "une baguette magique") ; weaponsList.append(magicWand)
        let butter = LolWeapon(name: "un couteau à beurre") ; weaponsList.append(butter)
        let flowers = LolWeapon(name: "un bouquet de fleurs") ; weaponsList.append(flowers)
        let tomatoes = LolWeapon(name: "des tomates") ; weaponsList.append(tomatoes)
        let bow = MedievalWeapon(name: "un arc") ; weaponsList.append(bow)
        let sword = MedievalWeapon(name: "un glaive") ; weaponsList.append(sword)
        let slingShot = MedievalWeapon(name: "une fronde") ; weaponsList.append(slingShot)
        let gun = FireWeapon(name: "un pistolet") ; weaponsList.append(gun)
        let revolver = FireWeapon(name: "un revolver") ; weaponsList.append(revolver)
        let rifle = FireWeapon(name: "un fusil") ; weaponsList.append(rifle)

        charactersList = []
        let policeMan = LawEnforcement(activity: "Policeman", weapon: gun) ; charactersList.append(policeMan)
        let military = LawEnforcement(activity: "Military", weapon: rifle) ; charactersList.append(military)
        let doctor = MedicalStaff(activity: "Doctor", weapon: bottle) ; charactersList.append(doctor)
        let nurse = MedicalStaff(activity: "Nurse", weapon: knife) ; charactersList.append(nurse)
        let ninja = AsianWarrior(activity: "Ninja", weapon: katana) ; charactersList.append(ninja)
        let samurai = AsianWarrior(activity: "Samurai", weapon: shuriken) ; charactersList.append(samurai)
        let knight = MedievalWarrior(activity: "Knight", weapon: sword) ; charactersList.append(knight)
        let warrior = MedievalWarrior(activity: "warrior", weapon: slingShot) ; charactersList.append(warrior)
        let boxer = Athlete(activity: "Boxer", weapon: knife) ; charactersList.append(boxer)
        let wrestler = Athlete(activity: "Wrestler", weapon: baseballBat) ; charactersList.append(wrestler)
    }
    
// CREER SA TEAM DE 3 PERSONNAGES ***
    func createTeam(_ player: Player){
        player.team = []
        initializeCharactersAndWeapons()
        charactersListToChoose = charactersList
        
        // Proposer d'ajouter un personnage tant qu'on n'en a pas 3
        while player.team.count < 3{
            
            // Afficher la liste des personnages disponibles
            showAliveCharacters(list: charactersListToChoose)
            print("\(player.name) : choisissez le personnage \((player.team.count) + 1) / 3 pour votre équipe en tapant son numéro.")
            
            //  Entrer le numéro du personnage choisi
            if let choice = readLine(){
                let choiceMember = Int(choice)!
                switch choiceMember {
                case 0..<charactersListToChoose.count :
                    player.team.append(charactersListToChoose[choiceMember])
                    nameCharacter(character: player.team.last!, player: player)
                    charactersListToChoose.remove(at: choiceMember)
                case  charactersListToChoose.count... :
                    print("Je ne reconnais pas ce personnage.")
                default :
                    print("Je ne comprends pas !")
                }
            }
        }
        //  Afficher l'équipe au complet
        print("Your TEAM :")
        showCharacters(list: player.team)
                
        //  calculer les stats de l'équipe
        player.calculateTeamStats()
    }

//  DONNER UN NOM UNIQUE AU PERSONNAGE ***
    func nameCharacter(character: Character, player: Player){
        var nameOk = false
        while nameOk == false {
            print("Veuillez lui donner un nom.")
            if let name = readLine(){
                nameOk = true
                for member in player.team {
                    if name == member.name {
                        nameOk = false
                    }
                }
                if nameOk == false {
                    print("Ce nom est déjà pris.")
                }else{
                    player.team.last!.name = name
                    print("You just add \(name) \(player.team.last!.activity) to your team.")
                }
            }
        }
    }
    
//  FAIRE APPARAITRE LE COFFRE ? (1 chance sur 3) ***
    func showChest() -> Bool{
        var proposeChest: Bool = false
        let x = Int.random(in: 0..<3)
        if x == 1{
            proposeChest = true
        }else{
            proposeChest = false
        }
        return proposeChest
    }
    
//  PROPOSER UNE ARME AU HASARD ***
    func randomWeapon() -> Weapon{
        let x = Int.random(in: 0..<weaponsList.count)
        let newWeapon = weaponsList[x]
        return newWeapon
    }

// CHANGER L'ARME DU PERSONNAGE ***
    func changeWeapon(of activeCharacter: Character, by newWeapon: Weapon){
        if newWeapon.damages >= activeCharacter.weapon.damages{
            print("Bonne pioche ! Vous échangez \(activeCharacter.weapon.name) pour \(newWeapon.name), qui inflige \((newWeapon.damages)-(activeCharacter.weapon.damages)) points de dégâts supplémentaires.")
        }else if newWeapon.name == activeCharacter.weapon.name {
            print("Kif kif ! Vous reprenez la même arme : \(activeCharacter.weapon.name).")
        }else if newWeapon.damages == activeCharacter.weapon.damages {
            print("Kif kif ! Vous échangez \(activeCharacter.weapon.name) pour \(newWeapon.name) qui inflige les mêmes dégâts.")
        }else{
            print("Oups Vous perdez au change ! Vous échangez \(activeCharacter.weapon.name) pour \(newWeapon.name), qui inflige \((activeCharacter.weapon.damages)-(newWeapon.damages)) points de dégâts de moins.")
        }
        activeCharacter.weapon = newWeapon
    }
    
//  CALCULER LES STATS ***
    func determineWinner() -> Player{
        playerOne.calculateTeamStats()
        playerTwo.calculateTeamStats()
        
        var winner = playerOne
        
        if playerOne.teamActualHealth < playerTwo.teamActualHealth {
            winner = playerTwo
        }else{
            winner = playerOne
        }
        return winner
    }
    
    func determineLooser() -> Player{
        playerOne.calculateTeamStats()
        playerTwo.calculateTeamStats()
        
        var looser = playerOne
        
        if playerOne.teamActualHealth < playerTwo.teamActualHealth {
            looser = playerTwo
        }else{
            looser = playerOne
        }
        return looser
    }

//  AFFICHER LES STATS DE LA PARTIE ***
    func showStats(_ winner: Player, _ looser: Player){
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
    
//  AFFICHER TOUS LES PERSONNAGES D'UNE LISTE ***
    func showCharacters(list: [Character]){
        for character in list{
            print("\(character.name), \(character.activity)")
        }
    }
    
//  AFFICHER TOUS LES PERSONNAGES VIVANTS D'UNE LISTE ***
    func showAliveCharacters(list: [Character]){
        print("Équipe :")
        for character in list where character.actualHealth > 0{
            print("N°\(list.firstIndex{$0 === character}!)")
            character.present()
        }
    }
    
// SELECTIONNER UN PERSONNAGE ***
    func selectCharacter(_ player: Player) -> Character{
        var choiceMember = -1
        let range = 0...player.team.count
        
        //  Choisir le personnage qui va réaliser l'action
        while !range.contains(choiceMember) || player.team[choiceMember].actualHealth <= 0{
            
            //  Afficher les personnages vivants de la team []
            showAliveCharacters(list: player.team)
            
            print("Choisissez un des personnages ci-dessus en tapant son numéro.")
            if let choice = readLine(){
                if Int(choice) == nil{
                    print("Je ne comprends pas.")
                }else{
                    choiceMember = Int(choice)!
                    if !range.contains(choiceMember){
                        print("Je ne comprends pas.")
                    }else if range.contains(choiceMember) && player.team[choiceMember].actualHealth <= 0{
                        print("Ce personnage \(player.team[choiceMember].name) est mort. Il faut choisir quelqu'un d'autre.")
                    }
                }
            }
        }
        print("Vous avez choisi \(player.team[choiceMember].name).")
        return player.team[choiceMember]
    }
    
// CHOISIR L'ACTION A REALISER (ATTAQUE OU SOIN) ***
    func chooseAction(of activeCharacter: Character) -> Int{
        var choiceAction = 0
        while choiceAction != 1 && choiceAction != 2 {
            print("Que voulez vous que \(activeCharacter.name) \(activeCharacter.activity) fasse ?")
            print("Tapez 1 : pour attaquer un adversaire")
            print("Tapez 2 : pour soigner un coéquipier")
            if let choice = readLine(){
                choiceAction = Int(choice)!
            }else{
                print("Je ne comprends pas votre choix.")
            }
        }
        return choiceAction
    }
            
    func executeAction(of activeCharacter: Character, from activePlayer: Player, to passivePlayer: Player){
        let choiceAction = chooseAction(of: activeCharacter)
        
        if choiceAction == 1{
            print("\(activeCharacter.name) est prêt pour attaquer.")
            print("Qui choisissez vous d'attaquer ?")
            showAliveCharacters(list: passivePlayer.team)
            let enemy = selectCharacter(passivePlayer)
            activeCharacter.attack(enemy: enemy)
        }else if choiceAction == 2{
            print("\(activeCharacter.name) est prêt.")
            print("Qui choisissez vous de spoigner ?")
            showAliveCharacters(list: activePlayer.team)
            let member = selectCharacter(activePlayer)
            activeCharacter.heal(teamMate: member)
        }
    }
    
    func askToKeepPlayerName(){
        var responseToQuestion = false
        while responseToQuestion == false {
                print("Voulez-vous rejouer en gardant les mêmes noms de joueurs ? Oui ou Non ?")
                if let response = readLine(){
                    if response.uppercased() == "OUI" || response.uppercased() == "YES"{
                        nbGames += 1
                        responseToQuestion = true
                        
                    }else if response.uppercased() == "NON" || response.uppercased() == "NO"{
                        nbGames = 0
                        responseToQuestion = true
                    }else{
                        print("Je ne comprends pas.")
                    }
                }
        }
    }
}


