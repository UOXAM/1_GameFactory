//
//  Game.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//s

import Foundation

class Game{
    
    let weaponsList: [Weapon] = [Knife(), BaseballBat(), Bottle(), Katana(), Shuriken() ,Nunchaku(), MangicSword(), Flowers(), MagicWand(), ButterKnife(), Flowers(), Tomatoes(), Bow(), Sword(), Gun(), Revolver(), Rifle()]
    let charactersList: [Character] = [Policeman(), Military(), Doctor(), Nurse(), Ninja(), Samurai(), Knight(), Warrior(), Boxer(), Wrestler()]
    var charactersListToChoose: [Character]
    var playerOne = Player(name: "Player 1")
    var playerTwo = Player(name: "Player 2")
    var turn: Double = 0.0
    var keepPlayerName = false
    
    
    init() {
        charactersListToChoose = charactersList
    }

    
//  ********************************
//       INITIALISATION DU JEU
//  ********************************

    // ----------------------------------------------------------------------------
    // INITIALISE LE JEU : DEMANDER DE JOUER, NOMMER LES JOUEURS, CRÉER LES ÉQUIPES
    // ----------------------------------------------------------------------------
    func initialisation(){
        
        // Si les mêmes joueurs rejouent ils gardent les mêmes noms de joueurs
        if keepPlayerName == false {
            nbGames = 0
            playerOne.nbVictory = 0
            playerTwo.nbVictory = 0
            playerOne.name = "Player 1"
            playerTwo.name = "Player 2"
            
            // Demander de jouer
            askToPlay()
            
            // Renseigner le nom des joueurs
            namePlayer(activePlayer)
            namePlayer(passivePlayer)
        }

        //  Créer les équipes et nommer ses personnages
        createTeam(activePlayer)
        createTeam(passivePlayer)
        
    }

    // ----------------------------------------------------------------------------
    // FONCTIONS PRIVÉES UTILISÉES DANS LA FONCTION INITIALISATION()
    // ----------------------------------------------------------------------------
        
    // PROPOSER DE JOUER UNE PARTIE
    private func askToPlay(){
        var playGame: Bool = false
        
        while playGame == false {
            let responseToQuestion = askYesNo(question: "Ready tu play ? Yes or No ?")
            if responseToQuestion == true {
                playGame = true
                stars()
                print("Great, let's start !")
                stars()
            }else{
                playGame = false
                print("Too bad... Are you shure... ?")
            }
        }
    }

    //  NOMMER UN JOUEUR
    private func namePlayer(_ player: Player) {
        while player.name == "Player 1" || player.name == "Player 2" || playerOne.name == playerTwo.name {
            print("\(player.name): enter your name")
            if let name = readLine(){
                player.name = name
                print("\n")
                if playerOne.name == playerTwo.name{
                    warningName()
                }
            }
        }
    }

    // CREER SA TEAM DE 3 PERSONNAGES
    private func createTeam(_ player: Player){
        player.team = []
        charactersListToChoose = charactersList
            
        // Proposer d'ajouter un personnage tant qu'on n'en a pas 3
        while player.team.count < 1{
                
            // Afficher la liste des personnages disponibles
            starsNoSpace()
            print("\n\(player.name) create your team :\n")
            starsNoSpace()
            showAliveCharacters(list: charactersListToChoose)
            print("\nChoose the character \((player.team.count) + 1) / 3 by entering his number.")
                
            //  Entrer le numéro du personnage choisi
            if let choice = readLine(), let choiceMember = Int(choice){
                switch choiceMember {
                case 0..<charactersListToChoose.count :
                    player.team.append(charactersListToChoose[choiceMember])
                    nameCharacter(character: player.team.last!, player: player)
                    charactersListToChoose.remove(at: choiceMember)
                default :
                    warningCharacter()
                }
            }else{
                warning()
            }
        }
        //  Afficher l'équipe au complet
        print("\n\(player.name), your TEAM :")
        line()
        showCharacters(list: player.team)
        line()
        print("")
            
        //  calculer les stats de l'équipe
        player.calculateTeamStats()
    }

    // DONNER UN NOM UNIQUE AU PERSONNAGE
    private func nameCharacter(character: Character, player: Player){
        var nameOk = false
        while nameOk == false {
            print("\nPlease give a name to \(character.activity).")
            if let name = readLine(){
                nameOk = true
                    
                // On vérifie que le nom n'est pas déjà utilisé dans la première équipe
                for member in playerOne.team {
                    if name == member.name {
                        nameOk = false
                    }
                }
                
                // On vérifie que le nom n'est pas déjà utilisé dans la deuxième équipe
                for member in playerTwo.team {
                    if name == member.name {
                        nameOk = false
                    }
                }
                if nameOk == false {
                    warningName()
                }else{
                    player.team.last!.name = name
                    print("\nYou just add \(name) \(player.team.last!.activity) to your team.\n")
                }
            }
        }
    }

//  ********************************
//       LANCEMENT LA PARTIE
//  ********************************

    // ----------------------------------------------------------------------------
    // LANCE LE JEU : CHAQUE TOUR LES JOUEURS JOUENT À LA SUITE TANT QU'IL RESTE
    //           AU MOINS UN PERSONNAGE VIVANT DANS CHAQUE TEAM
    // ----------------------------------------------------------------------------
    func play() {
    
        // On initialise le tour de jeu avant de commencer la partie
        turn = 0.5
            
        //  Tour de jeu : jouer à tour de rôle tant qu'au moins un personnage de chaque équipe est vivant
        while activePlayer.teamActualHealth > 0 && passivePlayer.teamActualHealth > 0 {
                
            // A chaque tour de jeu, le nombre de tour s'incrémente de 1
            turn += 0.5
                
            // Annonce du tour de jeu
            starsNoSpace()
            print("\nTURN \(Int(turn)) :")
            print("\(activePlayer.name), which member of your team will execute an action ?\n")
            starsNoSpace()
                
            //  Le Joueur choisit le personnage actif
            let activeCharacter = selectCharacter(activePlayer)
                
            //  Le jeu propose aléatoirement le coffre d'armes au personnage, contenant une arme au hasard. Si le joueur décide de l'ouvrir, le personnage changera d'arme automatiquement.
            proposeChest(to: activeCharacter)
                    
            //  Le joueur choisit quelle action il fait exécuter à son personnage (soin pour un coéquipier ou attaque d'un ennemi)
            executeAction(of: activeCharacter, from: activePlayer, to: passivePlayer)
                    
            // Si l'adversaire a encore au moins un personnage vivant dans sa team, il devient l'activePlayer et c'est à son tour de jouer (nouvelle boucle du while)
            if passivePlayer.teamActualHealth > 0{
                activePlayer = passivePlayer
                if activePlayer.name == playerOne.name {
                    passivePlayer = playerTwo
                }else{
                    passivePlayer = playerOne
                }
            }
                
        }
    }
    
    // ----------------------------------------------------------------------------
    // FONCTIONS PRIVÉES UTILISÉES DANS LA FONCTION PLAY()
    // ----------------------------------------------------------------------------
    

    //  AFFICHER TOUS LES PERSONNAGES D'UNE LISTE
    private func showCharacters(list: [Character]){
        for character in list{
            print("\(character.name), \(character.activity)")
        }
    }
        
    //  AFFICHER TOUS LES PERSONNAGES VIVANTS D'UNE LISTE
    private func showAliveCharacters(list: [Character]){
        line()
        for (index, character) in list.enumerated() where character.actualHealth > 0{
            print("\(index) : \(character.activity) -> Life : \(character.actualHealth)/\(character.health) | Weapon : \(character.weapon.name)(\(character.weapon.damages)) | Heal : \(character.heal)")
        }
        line()
    }
    
    // SELECTIONNER UN PERSONNAGE
    private func selectCharacter(_ player: Player) -> Character{
        var valideChoice = false
        let range = 0..<player.team.count
        var character :Character = player.team.first!
                
        //  Choisir le personnage qui va réaliser l'action
        while valideChoice == false{
                    
            //  Afficher les personnages vivants de la team []
            showAliveCharacters(list: player.team)
            print("\nChoose a character in the list and enter his number.")
                
            //  Vérifier que c'est bien un entier qui a été entré
            if let choice = readLine(), let choiceMember = Int(choice){
                if range.contains(choiceMember) && player.team[choiceMember].actualHealth > 0{
                    character = player.team[choiceMember]
                    print("You choose \(character.name), \(character.activity).")
                    valideChoice = true
                }else if range.contains(choiceMember) && player.team[choiceMember].actualHealth <= 0{
                    print("\n!!!!!!!!!!!    This character \(player.team[choiceMember].name) is dead. Please choose someone else    !!!!!!!!!!!")
                }else{
                    warningCharacter()
                }
            }else{
                warning()
            }
        }
        return character
    }
            
    //  PROPOSER DE MANIÈRE ALÉATOIRE (1 chance sur 3) UN COFFRE CONTENANT UNE ARME AU HASARD. SI LE JOUEUR DÉCIDE DE L'OUVRIR, SON PERSONNAGE CHANGERA D'ARME.
    private func proposeChest(to activeCharacter: Character){
        let x = Int.random(in: 0..<3)
        if x == 1{
            openChest(activeCharacter)
        }
    }
    
        //  PROPOSER D'OUVRIR LE COFFRE (FONCTION UTILISÉE DANS PROPOSECHEST()
        private func openChest(_ activeCharacter: Character){
            questionMarks()
            print("A chest appears with a random weapon inside. If you open it, your character will take this new weapon.")
            questionMarks()
            let responseToQuestion = askYesNo(question: "Do you want to open the chest ? Yes or No ?")
                
            //   Si sa réponse est "oui", une arme aléatoire apparaît et le personnage change d'arme
            if responseToQuestion == true {
                let newWeapon = randomWeapon()
                changeWeapon(of: activeCharacter, by: newWeapon)
            //  Si sa réponse est non : le personnage garde son arme actuelle et continue le jeu
            }else{
                print("Never mind ! let's continue the game.")
            }
        }
                
        //  PROPOSER UNE ARME AU HASARD (FONCTION UTILISÉE DANS OPENCHEST()
        private func randomWeapon() -> Weapon{
            let x = Int.random(in: 0..<weaponsList.count)
            let newWeapon = weaponsList[x]
            return newWeapon
        }
    
        // CHANGER L'ARME DU PERSONNAGE (FONCTION UTILISÉE DANS OPENCHEST()
        private func changeWeapon(of activeCharacter: Character, by newWeapon: Weapon){
            if newWeapon.damages > activeCharacter.weapon.damages{
                print("")
                starsNoSpace()
                print("Fantastic ! You let \(activeCharacter.weapon.name) and take \(newWeapon.name), which will cause \((newWeapon.damages)-(activeCharacter.weapon.damages)) points more pain.")
                starsNoSpace()
            }else if newWeapon.name == activeCharacter.weapon.name {
                line()
                print("Equally ! You take the same weapon : \(activeCharacter.weapon.name).")
                line()
            }else if newWeapon.damages == activeCharacter.weapon.damages {
                line()
                print("Equally ! You let \(activeCharacter.weapon.name) and take \(newWeapon.name), which will cause same pain.")
                line()
            }else{
                line()
                print("Damn ! You loose \(activeCharacter.weapon.name) and take \(newWeapon.name), which will cause \((activeCharacter.weapon.damages)-(newWeapon.damages)) points less pain.")
                line()
            }
            activeCharacter.weapon = newWeapon
        }

    // CHOISIR L'ACTION A REALISER (ATTAQUE OU SOIN)
    private func chooseAction(of activeCharacter: Character) -> Int{
        var valideReadLine: Bool = false
        var validNumber: Int = 0
                
        while valideReadLine == false{
            print("\nWhat action \(activeCharacter.name) \(activeCharacter.activity) will do ?\n")
            print("Enter 1 : to attack an enemy (-\(activeCharacter.weapon.damages) pts)")
            print("Enter 2 : to heal a team mate (+\(activeCharacter.heal) pts)")
                    
            if let choice = readLine(), let choiceAction = Int(choice){
                if choiceAction == 1 || choiceAction == 2{
                    valideReadLine = true
                    validNumber = choiceAction
                }else{
                    warning()
                }
            }
        }
        return validNumber
    }

    // EXÉCUTER L'ACTION CHOISIE
    private func executeAction(of activeCharacter: Character, from activePlayer: Player, to passivePlayer: Player){
        let choiceAction = chooseAction(of: activeCharacter)
                
        if choiceAction == 1{
            print("\n\(activeCharacter.name) is ready to fight.")
            print("\nWho do you want to attack ?")
            let enemy = selectCharacter(passivePlayer)
            activeCharacter.attack(enemy: enemy)
            activeCharacter.nbAttack += 1
                    
        }else if choiceAction == 2{
            print("\n\(activeCharacter.name) is ready.")
            print("Who do you want to heal ?")
            let member = selectCharacter(activePlayer)
            activeCharacter.heal(teamMate: member)
            activeCharacter.nbHeal += 1
        }
        //  calculer les stats de l'équipe
        activePlayer.calculateTeamStats()
        passivePlayer.calculateTeamStats()
    }
    

//  ********************************
//           FINALISATION
//  ********************************

    // ----------------------------------------------------------------------------
    // FINALISATION : A LA FIN DE CHAQUE PARTIE ON AFFICHE LES STATS ET ON PROPOSE
    //              DE REJOUER EN GARDANT LES MÊMES NOMS DE JOUEURS
    // ----------------------------------------------------------------------------
    
    func finalisation(){
        // La partie terminée, on déterminer le gagnant et le perdant
        let winner = determineWinner()
        let looser = determineLooser()
        
        // On ajoute une partie de gagnée au palmares du joueur vainqueur
        winner.nbVictory += 1

        // Les stats de la partie sont affichés
        showStats(winner, looser)
            
        // Il est proposé aux joueurs de faire une nouvelle partie en gardant les mêmes noms de joueurs. Ensuite la boucle newGame est relancée et en fonction de la réponse, il sera poroposé de nommer les joueurs (dans ce cas le nombre de parties jouées repasse a 0) ou non (dans ce cas le nombre de parties jouées s'incrément de 1).
        keepPlayerName = askToKeepPlayerName()
    }
    
    // ----------------------------------------------------------------------------
    // FONCTIONS PRIVÉES UTILISÉES DANS LA FONCTION FINALISATION()
    // ----------------------------------------------------------------------------
    
    //  DETERMINER LE GAGNANT
    private func determineWinner() -> Player{
        var winner : Player
            
        if playerOne.teamActualHealth < playerTwo.teamActualHealth {
            winner = playerTwo
        }else{
            winner = playerOne
        }
        return winner
    }
        
    // DETERMINER LE PERDANT
    private func determineLooser() -> Player{
        var looser : Player
        
        if playerOne.teamActualHealth < playerTwo.teamActualHealth {
            looser = playerOne
        }else{
            looser = playerTwo
        }
        return looser
    }

    //  AFFICHER LES STATS DE LA PARTIE
    private func showStats(_ winner: Player, _ looser: Player){
        stars()
        print("THE GAME LAST \(Int(turn)) TURNS !")
        stars()
        print("<<< The Winner is \(winner.name) ! >>>")
        print("Health of the team : \(winner.teamActualHealth) / \(winner.teamInitialHealth)")
        print("Number of attacks : \(winner.teamNbAttack)")
        print("Number of heals : \(winner.teamNbHeal)\n")
        print("TEAM :")
        line()
        showCharacters(list: winner.team)
        line()
            
        stars()
        
        print("<<< \(looser.name) : game over ! >>>")
        print("Health of the team : \(looser.teamActualHealth) / \(looser.teamInitialHealth)")
        print("Number of attacks : \(looser.teamNbAttack)")
        print("Number of heals : \(looser.teamNbHeal)\n")
        print("TEAM :")
        line()
        showCharacters(list: looser.team)
        line()
            
        stars()
            
        print("Nomber of games won by \(winner.name) : \(winner.nbVictory)")
        print("Nomber of games won by \(looser.name) : \(looser.nbVictory)")

        stars()
    }
    
    // PROPOSER DE REJOUER EN GARDANT LES MÊMES NOMS DE JOUEURS
    private func askToKeepPlayerName() -> Bool{
        let responseToQuestion = askYesNo(question: "Do you want to play again with the same player names ? Yes or no ?")
            
        if responseToQuestion == true {
            nbGames += 1
        }else{
            nbGames = 0
            playerOne.nbVictory = 0
            playerTwo.nbVictory = 0
        }
        return responseToQuestion
    }
    

    
    
//  ******************************************************************************************
//        FONCTIONS PRIVÉES GÉNÉRIQUES UTILISÉES DANS PLUSIEURS AUTRES FONCTIONS
//  ******************************************************************************************
    
    // POSER UNE QUESTION ACCEPTANT EN RÉPONSE OUI OU NON
    private func askYesNo(question: String) -> Bool{
        var askAgain = true
        var responseToQuestion = false
    
        while askAgain == true {
                print("\n\(question)")
                if let response = readLine(){
                    if response.uppercased() == "OUI" || response.uppercased() == "YES" || response.uppercased() == "OK"{
                        responseToQuestion = true
                        askAgain = false
                        
                    }else if response.uppercased() == "NON" || response.uppercased() == "NO" || response.uppercased() == "NOPE"{
                        responseToQuestion = false
                        askAgain = false
                    }else{
                        warning()
                    }
                }
        }
        return responseToQuestion
    }
    
    // MESSAGE D'ERREUR : I DON'T UNDERSTAND
    private func warning(){
        print("\n!!!!!!!!!!!!!!!!!!!!!")
        print("I don't understand...")
        print("!!!!!!!!!!!!!!!!!!!!!\n")
    }
    
    // MESSAGE D'ERREUR : I DON'T RECOGNIZE THIS CHARACTER
    private func warningCharacter(){
        print("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("I don't recognize this character...")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
    }
    
    // MESSAGE D'ERREUR : NAME ALREADY TAKEN
    private func warningName(){
        print("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("This name is already taken...")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
    }
    
    // MISE EN FORME : SAUT DE LIGNE + LIGNE * + SAUT DE LIGNE
    private func stars(){
        print("\n*************************************************************************\n")
    }
    
    // MISE EN FORME : SAUT DE LIGNE + LIGNE ? + SAUT DE LIGNE
    private func questionMarks(){
        print("\n?????????????????????????????????????????????????????????????????????????\n")
    }
    
    // MISE EN FORME : LIGNE -
    private func line(){
        print("-------------------------------------------------------------------------")
    }
    
    // MISE EN FORME : LIGNE *
    private func starsNoSpace(){
        print("*************************************************************************")
    }
}

