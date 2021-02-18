//
//  Game.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

class Game{
    
    private let weaponsList: [Weapon] = [Knife(), BaseballBat(), Bottle(), Katana(), Shuriken() ,Nunchaku(), MangicSword(), Flowers(), MagicWand(), ButterKnife(), Flowers(), Tomatoes(), Bow(), Sword(), Gun(), Revolver(), Rifle()]
    var playerOne = Player(name: "Player 1")
    var playerTwo = Player(name: "Player 2")
    private var turn: Double = 0.0
    private var keepPlayerName = false

    
//  ********************************
//       INITIALIZATION OF GAME
//  ********************************

    // ----------------------------------------------------------------------------
    // INITIALIZE GAME : ASK TO PLAY DE JOUER, NAME CHARACTERS, CREATE TEAM
    // ----------------------------------------------------------------------------
    func initialisation(){
        
        // If the players want to play again and keep their name of player
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
    // PRIVATE FUNCTIONS USED IN THE FUNCTION INITIALIZATION()
    // ----------------------------------------------------------------------------
        
    // PROPOSE TO PLAY
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

    //  NAME PLAYER
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

    // CREATE TEAM OF 3 CHARACTERS
    private func createTeam(_ player: Player){
        player.team = []
        var charactersList: [Character] = [Policeman(), Military(), Doctor(), Nurse(), Ninja(), Samurai(), Knight(), Warrior(), Boxer(), Wrestler()]

        // Propose to add a character until the team is composed by 3 members
        while player.team.count < 3{
                
            // Show list of available characters (a character can be add once per team, but each team can add the same character)
            starsNoSpace()
            print("\n\(player.name) create your team :\n")
            starsNoSpace()
            showAliveCharacters(list: charactersList)
            print("\nChoose the character \((player.team.count) + 1) / 3 by entering his number.")
                
            //  Enter the number of the character chosen
            if let choice = readLine(), let choiceMember = Int(choice){
                switch choiceMember {
                case 0..<charactersList.count :
                    player.team.append(charactersList[choiceMember])
                    nameCharacter(character: player.team.last!, player: player)
                    charactersList.remove(at: choiceMember)
                default :
                    warningCharacter()
                }
            }else{
                warning()
            }
        }
        //  Show the Team members (characters)
        print("\n\(player.name), your TEAM :")
        line()
        showCharacters(list: player.team)
        line()
        print("")
            
        //  Calculate stats of the team
        player.calculateTeamStats()
    }

    // GIVE A UNIQUE NAME TO THE CHARACTER CHOSEN (EACH CHARACTER SHOULD HAVE DIFFERENT NAM OF OTHER CHARACTERS OF THE 2 TEAMS)
    private func nameCharacter(character: Character, player: Player){
        var nameOk = false
        while nameOk == false {
            print("\nPlease give a name to \(character.activity).")
            if let name = readLine(){
                nameOk = true
                    
                // Check if the name is already used in the first team
                for member in playerOne.team {
                    if name == member.name {
                        nameOk = false
                    }
                }
                
                // Check if the name is already used in the second team
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
//       START THE GAME
//  ********************************

    // ----------------------------------------------------------------------------
    //              START THE GAME : EACH TURN BOTH PLAYERS PLAY
    //            WHILE BOTH TEAMS HAVE AT LEAST ONE CHARACTER ALIVE
    // ----------------------------------------------------------------------------
    func play() {
    
        // We initialize the number of turns before to start to play
        turn = 0.5
            
        //  Game Turn : players take turns while at least one character of both teams is alive
        while activePlayer.teamActualHealth > 0 && passivePlayer.teamActualHealth > 0 {
                
            // Each turn the number of turn increase
            turn += 0.5
                
            // Show which turn number is ongoing
            starsNoSpace()
            print("\nTURN \(Int(turn)) :")
            print("\(activePlayer.name), which member of your team will execute an action ?\n")
            starsNoSpace()
                
            //  Player choose a member of his team to play -> the active character
            let activeCharacter = selectCharacter(activePlayer)
                
            //  The Game proposes by random a chest which contain a random weapon. If the player decide to open it, the active character will take this new weapon instead of his actual one (the random weapon can be the same or worse)
            proposeChest(to: activeCharacter)
                    
            //  The player choose which action his active charatcr will do (to heal team mate or himself || or || to attack enemy)
            executeAction(of: activeCharacter, from: activePlayer, to: passivePlayer)
                    
            // If the opponent player still has an alive character in his team, it's his turn to play -> he beacomes the active player
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
    // PRIVATE FUNCTIONS USED IN THE FUNCTION PLAY()
    // ----------------------------------------------------------------------------
    

    //  SHOW ALL CHARACTERS OF A LIST
    private func showCharacters(list: [Character]){
        for character in list{
            if character.name != "" {
                print("\(character.name), \(character.activity) -> Life : \(character.actualHealth)/\(character.health) | Weapon : \(character.weapon.name)(\(character.weapon.damages)) | Heal : \(character.heal)")
            }else{
                print("\(character.activity) -> Life : \(character.actualHealth)/\(character.health) | Weapon : \(character.weapon.name)(\(character.weapon.damages)) | Heal : \(character.heal)")
            }
        }
    }
        
    //  SHOW ALL ALIVE CHARACTERS OF A LIST
    private func showAliveCharacters(list: [Character]){
        line()
        for (index, character) in list.enumerated() where character.actualHealth > 0{
            if character.name != "" {
                print("\(index) : \(character.name), \(character.activity) -> Life : \(character.actualHealth)/\(character.health) | Weapon : \(character.weapon.name)(\(character.weapon.damages)) | Heal : \(character.heal)")
            }else{
                print("\(index) : \(character.activity) -> Life : \(character.actualHealth)/\(character.health) | Weapon : \(character.weapon.name)(\(character.weapon.damages)) | Heal : \(character.heal)")
            }
        }
        line()
    }
    
    // SELECT A CHARACTER (OF THE ACTIVE PLAYER TEAM) TO DO AN ACTION
    private func selectCharacter(_ player: Player) -> Character{
        var valideChoice = false
        let range = 0..<player.team.count
        var character :Character = player.team.first!
                
        //  CHOOSE A CHARACTER
        while valideChoice == false{
                    
            //  SHOW ALIVE CHARACTERS OF HIS TEAM
            showAliveCharacters(list: player.team)
            print("\nChoose a character in the list and enter his number.")
                
            //  VERIFY THE PLAYER HAS CHOSEN A VALID CHARACTER BY ENTERING HIS NUMBER
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
            
    //  PROPOSE RANDOMLY (1 IN 3 CHANCE) A CHEST CONTAINING A RANDOM WEAPON. IF THE PLAYER OPEN IT, HIS CHARACTER WILL TAKE THIS NEW WEAPON INSTEAD OF THE OLD ONE.
    private func proposeChest(to activeCharacter: Character){
        let x = Int.random(in: 0..<3)
        if x == 1{
            openChest(activeCharacter)
        }
    }
    
        //  ASK TO OPEN THE CHEST (FUNCTION USED IN PROPOSECHEST())
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
                
        //  PICK RANDOMLY A WEAPON (FUNCTION USED IN OPENCHEST())
        private func randomWeapon() -> Weapon{
            let x = Int.random(in: 0..<weaponsList.count)
            let newWeapon = weaponsList[x]
            return newWeapon
        }
    
        // THE ACTIVE CHARACTER TAKE THIS NEW WEAPON INSTEAD OF THE OLD ONE (FUNCTION USED IN OPENCHEST())
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

    // CHOOSE WHICH ACTION THE ACTIVE CHARACTER WILL DO (TO ATTACK OR TO HEAL)
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

    // ACTIVE CHARACTER EXECUTES THE ACTION CHOSEN
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
        //  CALCULATE THE STATS OF THE TEAM
        activePlayer.calculateTeamStats()
        passivePlayer.calculateTeamStats()
    }
    

//  ********************************
//           FINALIZATION
//  ********************************

    // ----------------------------------------------------------------------------
    // FINALIZATION : AT THE END OF THE GAME THE STATS ARE DISPLAYED AND
    // WE ASK TO PLAY AGAIN WHILE KEEPING THE SAME PLAYER NAMES
    // ----------------------------------------------------------------------------
    
    func finalisation(){
        // At the end of the game, we determinate the winner and the looser
        let winner = determineWinner()
        let looser = determineLooser()
        
        // We add this victory to the player track record
        winner.nbVictory += 1

        // Stats of the game are displayed
        showStats(winner, looser)
        
        // We propose to play again with the same player names. Then a new game is proposed. According to the response, players will have to enter new player names and the stats will be reset, or continue with same player names (and add 1 to the number of games played).
        keepPlayerName = askToKeepPlayerName()
    }
    
    // ----------------------------------------------------------------------------
    // PRIVATE FUNCTIONS USED IN THE FUNCTION FINALIZATION()
    // ----------------------------------------------------------------------------
    
    //  DETERMINATE THE WINNER
    private func determineWinner() -> Player{
        var winner : Player
            
        if playerOne.teamActualHealth < playerTwo.teamActualHealth {
            winner = playerTwo
        }else{
            winner = playerOne
        }
        return winner
    }
        
    // DETERMINATE THE LOOSER
    private func determineLooser() -> Player{
        var looser : Player
        
        if playerOne.teamActualHealth < playerTwo.teamActualHealth {
            looser = playerOne
        }else{
            looser = playerTwo
        }
        return looser
    }

    //  DISPLAY STATS OF THE GAME
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
    
    // ASK TO PLAY AGAIN WITH THE SAME PLAYER NAMES
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
//        TOOL BOX : PRIVATE FUNCTIONS USED IN OTHER FUNCTION
//  ******************************************************************************************
    
    // ASK A QUESTION ACCEPTING ONLY A RESPONSE YES OR NO
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
    
    // ERROR MESSAGE : "I DON'T UNDERSTAND"
    private func warning(){
        print("\n!!!!!!!!!!!!!!!!!!!!!")
        print("I don't understand...")
        print("!!!!!!!!!!!!!!!!!!!!!\n")
    }
    
    // ERROR MESSAGE : "I DON'T RECOGNIZE THIS CHARACTER"
    private func warningCharacter(){
        print("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("I don't recognize this character...")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
    }
    
    // ERROR MESSAGE : "NAME ALREADY TAKEN"
    private func warningName(){
        print("\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
        print("This name is already taken...")
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n")
    }
    
    // FORMATTING : LINE BREAK + LINE OF STARS * + LINE BREAK
    private func stars(){
        print("\n*************************************************************************\n")
    }
    
    // FORMATTING : LINE BREAK + LINE OF QUESTION MARKS ? + LINE BREAK
    private func questionMarks(){
        print("\n?????????????????????????????????????????????????????????????????????????\n")
    }
    
    // FORMATTING : LINE OF HYPHEN -
    private func line(){
        print("-------------------------------------------------------------------------")
    }
    
    // MISE EN FORME : LINE OF STARS *
    private func starsNoSpace(){
        print("*************************************************************************")
    }
}

