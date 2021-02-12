//
//  Game.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

class Game{
    
    let weaponsList: [Weapon] = [Knife(), BaseballBat(), Bottle(), Katana(), Shuriken() ,Nunchaku(), MangicSword(), Flowers(), MagicWand(), ButterKnife(), Flowers(), Tomatoes(), Bow(), Sword(), Gun(), Revolver(), Rifle()]
    let charactersList: [Character] = [Policeman(), Military(), Doctor(), Nurse(), Ninja(), Samurai(), Knight(), Warrior(), Boxer(), Wrestler()]
    var charactersListToChoose: [Character]
    var playerOne = Player(name: "Player 1")
    var playerTwo = Player(name: "Player 2")
    
    init() {
        charactersListToChoose = charactersList
    }

//  NOMMER UN JOUEUR ***
    func namePlayer(_ player: Player) {
        while player.name == "Player 1" || player.name == "Player 2" || playerOne.name == playerTwo.name {
            print("\n\(player.name): enter your name")
            if let name = readLine(){
                player.name = name
                if playerOne.name == playerTwo.name{
                    print("\n!!!!!!!!!!!    These name is already taken by the other player    !!!!!!!!!!!")
                }
            }
        }
    }

    
    
//  PROPOSER DE JOUER UNE PARTIE ***
    func askToPlay(){
        var playGame = false
        while playGame == false {
            print("\nReady to play ? Yes or not ?")
            if let response = readLine(){
                if response.uppercased() == "OUI" || response.uppercased() == "YES"{
                    playGame = true
                }else if response.uppercased() == "NON" || response.uppercased() == "NO"{
                    print("Too bad... Are you shure... ?")
                }else{
                    print("\n!!!!!!!!!!!    I don't understand your answer    !!!!!!!!!!!")
                }
            }
        }
        print("\n*********************************\n\nGreat, let's start to create your teams !\n\n*********************************")
    }
    
    
// CREER SA TEAM DE 3 PERSONNAGES ***
    func createTeam(_ player: Player){
        player.team = []
        charactersListToChoose = charactersList
        
        // Proposer d'ajouter un personnage tant qu'on n'en a pas 3
        while player.team.count < 3{
            
            // Afficher la liste des personnages disponibles
            showAliveCharacters(list: charactersListToChoose)
            print("\n\(player.name) : choose the character \((player.team.count) + 1) / 3 for your team by entering his number.")
            
            //  Entrer le numéro du personnage choisi
//            if let choice = readLine(), let choiceMember = Int(choice)!{
            if let choice = readLine(), let choiceMember = Int(choice)!{
                switch choiceMember {
                case 0..<charactersListToChoose.count :
                    player.team.append(charactersListToChoose[choiceMember])
                    nameCharacter(character: player.team.last!, player: player)
                    charactersListToChoose.remove(at: choiceMember)
                default :
                    print("\n!!!!!!!!!!!    I don't recongnize this character    !!!!!!!!!!!")
                }
            }else{
                print("\n!!!!!!!!!!!    I don't understand    !!!!!!!!!!!")
            }
        }
        //  Afficher l'équipe au complet
        print("\nYour TEAM :")
        showCharacters(list: player.team)
                
        //  calculer les stats de l'équipe
        player.calculateTeamStats()
    }

//  DONNER UN NOM UNIQUE AU PERSONNAGE ***
    func nameCharacter(character: Character, player: Player){
        var nameOk = false
        while nameOk == false {
            print("\nPlease give a name to \(character.activity).")
            if let name = readLine(){
                nameOk = true
                for member in player.team {
                    if name == member.name {
                        nameOk = false
                    }
                }
                if nameOk == false {
                    print("\n!!!!!!!!!!!    This name is already taken    !!!!!!!!!!!")
                }else{
                    player.team.last!.name = name
                    print("You just add \(name) \(player.team.last!.activity) to your team.\n")
                }
            }
        }
    }
    
//  PROPOSER DE MANIÈRE ALÉATOIRE (1 chance sur 3) UN COFFRE CONTENANT UNE ARME AU HASARD. SI LE JOUEUR DÉCIDE DE L'OUVRIR, SON PERSONNAGE CHANGERA D'ARME.  ***
    func proposeChest(to activeCharacter: Character){
        let x = Int.random(in: 0..<3)
        if x == 1{
            openChest(activeCharacter)
        }
    }
    
//  PROPOSER UNE ARME AU HASARD ***
    private func randomWeapon() -> Weapon{
        let x = Int.random(in: 0..<weaponsList.count)
        let newWeapon = weaponsList[x]
        return newWeapon
    }

//  PROPOSER D'OUVRIR LE COFFRE ***
    private func openChest(_ activeCharacter: Character){
        print("\n? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?\nA chest appears with a random weapon inside. If you open it, your character will take this new weapon.")
        print("Do you want to open the chest ? Yes or no ?\n? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?")

        //   La réponse du joueur est collectée
        if let responseToOpenChest = readLine(){
                       
            //   Si sa réponse est "oui", une arme aléatoire apparaît et le personnage change d'arme
            if responseToOpenChest.uppercased() == "OUI" || responseToOpenChest.uppercased() == "YES" || responseToOpenChest.uppercased() == "OK"{
                    let newWeapon = randomWeapon()
                    changeWeapon(of: activeCharacter, by: newWeapon)
            //  Si sa réponse est non : le personnage garde son arme actuelle et continue le jeu
            }else{
                print("Never mind ! let's continue the game.")
            }
        }
    }
    
    

// CHANGER L'ARME DU PERSONNAGE ***
    private func changeWeapon(of activeCharacter: Character, by newWeapon: Weapon){
        if newWeapon.damages > activeCharacter.weapon.damages{
            print("\nFantastic ! You let \(activeCharacter.weapon.name) and take \(newWeapon.name), which will cause  \((newWeapon.damages)-(activeCharacter.weapon.damages)) points more pain.")
        }else if newWeapon.name == activeCharacter.weapon.name {
            print("\nEqually ! You take the same weapon : \(activeCharacter.weapon.name).")
        }else if newWeapon.damages == activeCharacter.weapon.damages {
            print("\nEqually ! You let \(activeCharacter.weapon.name) and take \(newWeapon.name), which will cause same pain.")
        }else{
            print("\nDamn a bullshit weapon ! You loose \(activeCharacter.weapon.name) and take \(newWeapon.name), which will cause \((activeCharacter.weapon.damages)-(newWeapon.damages)) points less pain.")
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
        print("\nThe Winner is \(winner.name) !")
        print("Health of the team : \(winner.teamActualHealth) / \(winner.teamInitialHealth)")
        print("Nomber of attacks : \(winner.teamNbAttack)")
        print("Nomber of heals : \(winner.teamNbHeal)")
        showCharacters(list: winner.team)
        
        print("/n \(looser.name) : game over !")
        print("Health of the team : \(looser.teamActualHealth) / \(looser.teamInitialHealth)")
        print("Nomber of attacks : \(looser.teamNbAttack)")
        print("Nomber of heals : \(looser.teamNbHeal)")
        showCharacters(list: looser.team)

        print("\nNomber of games won by \(winner.name) : \(winner.nbVictory)")
        print("Nomber of games won by \(looser.name) : \(looser.nbVictory)")
    }
    
//  AFFICHER TOUS LES PERSONNAGES D'UNE LISTE ***
    func showCharacters(list: [Character]){
        for character in list{
            print("\(character.name), \(character.activity)")
        }
    }
    
//  AFFICHER TOUS LES PERSONNAGES VIVANTS D'UNE LISTE ***
    func showAliveCharacters(list: [Character]){
        print("\n----------------------------------------------")
        for (index, character) in list.enumerated() where character.actualHealth > 0{
            print("\(index) : \(character.activity) -> Life : \(character.actualHealth)/\(character.health) | Weapon : \(character.weapon.name)(\(character.weapon.damages)) | Heal : \(character.heal)")
        }
        print("----------------------------------------------")
    }
    
//    func showAliveCharacters(list: [Character]){
//        print("Équipe :")
//        for character in list where character.actualHealth > 0{
//            print("N°\(list.firstIndex{$0 === character}!)")
//            character.present()
//        }
//    }
//
    
// SELECTIONNER UN PERSONNAGE ***
    func selectCharacter(_ player: Player) -> Character{
        var choiceMember = -1
        let range = 0..<player.team.count
        
        //  Choisir le personnage qui va réaliser l'action
        while !range.contains(choiceMember) || player.team[choiceMember].actualHealth <= 0{
            
            //  Afficher les personnages vivants de la team []
            showAliveCharacters(list: player.team)
            
            print("Choose a character in the list and enter his number.")
            if let choice = readLine(){
                if Int(choice) == nil{
                    print("\n!!!!!!!!!!!    I don't understand    !!!!!!!!!!!")
                }else{
                    choiceMember = Int(choice)!
                    if !range.contains(choiceMember){
                        print("\n!!!!!!!!!!!    I don't understand    !!!!!!!!!!!")
                    }else if range.contains(choiceMember) && player.team[choiceMember].actualHealth <= 0{
                        print("\n!!!!!!!!!!!    This character \(player.team[choiceMember].name) is dead. Please choose someone else    !!!!!!!!!!!")
                    }
                }
            }
        }
        print("You choose \(player.team[choiceMember].name), \(player.team[choiceMember].activity).")
        return player.team[choiceMember]
    }
    
// CHOISIR L'ACTION A REALISER (ATTAQUE OU SOIN) ***
    func chooseAction(of activeCharacter: Character) -> Int{
        var choiceAction = 0
        while choiceAction != 1 && choiceAction != 2 {
            print("\nWhat action \(activeCharacter.name) \(activeCharacter.activity) will do ?")
            print("Enter 1 : to attack an enemy")
            print("Enter 2 : to heal a team mate")
            if let choice = readLine(){
                choiceAction = Int(choice)!
            }else{
                print("\n!!!!!!!!!!!    I don't understand    !!!!!!!!!!!")
            }
        }
        return choiceAction
    }
            
    func executeAction(of activeCharacter: Character, from activePlayer: Player, to passivePlayer: Player){
        let choiceAction = chooseAction(of: activeCharacter)
        
        if choiceAction == 1{
            print("\n\(activeCharacter.name) is ready to fight.")
            print("Who do you want to attack ?")
//            showAliveCharacters(list: passivePlayer.team)
            let enemy = selectCharacter(passivePlayer)
            activeCharacter.attack(enemy: enemy)
        }else if choiceAction == 2{
            print("\n\(activeCharacter.name) is ready.")
            print("Who do you want to heal ?")
            showAliveCharacters(list: activePlayer.team)
            let member = selectCharacter(activePlayer)
            activeCharacter.heal(teamMate: member)
        }
    }
    
    func askToKeepPlayerName(){
        var responseToQuestion = false
        while responseToQuestion == false {
                print("\nDo you want to play again with the same player names ? Yes or not ?")
                if let response = readLine(){
                    if response.uppercased() == "OUI" || response.uppercased() == "YES" || response.uppercased() == "OK"{
                        nbGames += 1
                        responseToQuestion = true
                        
                    }else if response.uppercased() == "NON" || response.uppercased() == "NO" || response.uppercased() == "NOPE"{
                        nbGames = 0
                        responseToQuestion = true
                    }else{
                        print("\n!!!!!!!!!!!    I don't understand    !!!!!!!!!!!")
                    }
                }
        }
    }
}


