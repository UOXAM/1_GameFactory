//
//  main.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

///
///
/// PROPOSER DE LANCER UNE PARTIE  !
///
///
///



///
///
/// LANCER UNE PARTIE
///
///

// DEMARRER UNE SESSION
//var newSession: Bool = true
var nbGames: Int = 0

var game = Game()

// UNE SESSION PEUT CONTENIR PLUSIEURS PARTIES
//while nbGames >= 0 {
    
    // Initialiser le jeu si c'est une nouvelle session
//    if nbGames == 0{
//        game = Game()
//    }
        
    // DEMARRER UNE PARTIE
    // Demander de jouer :
game.askToPlay()
        
    // Définir le personnage qui jouera en premier
    var activePlayer = game.playerOne
    var passivePlayer = game.playerTwo

    // Si les mêmes joueurs rejouent ils gardent les mêmes noms de joueurs
    if nbGames == 0 {
        // Renseigner le nom des joueurs
        game.namePlayer(activePlayer)
        game.namePlayer(passivePlayer)
    }
        
    //  Créer les équipes et nommer ses personnages
    game.createTeam(activePlayer)
    game.createTeam(passivePlayer)
        
    //  Démarrer le jeu : Jouer à tour de rôle tant qu'au moins un personnage de chaque équipe est vivant
    while activePlayer.teamActualHealth > 0 && passivePlayer.teamActualHealth > 0 {
                   
        //  Le Joueur choisit le personnage actif
        let activeCharacter = game.selectCharacter(activePlayer)
                   
        //  Le jeu propose aléatoirement le coffre d'armes au personnage
        let proposeChest = game.showChest()
                   
        //  Si le coffre lui est proposé, il peut choisir de l'ouvrir :
        if proposeChest == true{
            print("Un coffre contenant une armé aléatoire vous est proposé. Si vous l'ouvrez votre personnage devra prendre cette nouvelle arme.")
            print("Voulez vous ouvrir ce coffre ? oui ou non ?")

            //   La réponse du joueur est collectée
            if let responseToOpenChest = readLine(){
                           
                //   Si sa réponse est "oui", une arme aléatoire apparaît et le personnage change d'arme
                if responseToOpenChest.uppercased() == "OUI" || responseToOpenChest.uppercased() == "YES"{
                        let newWeapon = game.randomWeapon()
                        game.changeWeapon(of: activeCharacter, by: newWeapon)
                //  Si sa réponse est non : le personnage garde son arme actuelle et continue le jeu
                }else{
                    print("Ok, une prochaine fois peut être. Continuons le jeu.")
                }
            }
        }
            
        //  Le joueur choisit quelle action il fait exécuter à son personnage (soin pour un coéquipier ou attaque d'un ennemi)
        game.executeAction(of: activeCharacter, from: activePlayer, to: passivePlayer)
            
            
        // Si l'adversaire a encore au moins un personnage vivant dans sa team, il devient l'activePlayer et c'est à son tour de jouer (nouvelle boucle du while)
        if passivePlayer.teamActualHealth > 0{
            activePlayer = passivePlayer
            if activePlayer.name == game.playerOne.name {
                passivePlayer = game.playerTwo
            }else{
                passivePlayer = game.playerOne
            }
        }
    }
        
    // La partie est terminée, on déterminer le gagnant et le perdant
    let winner = game.determineWinner()
    let looser = game.determineLooser()
    
    // On ajoute une partie de gagnée au palmares du joueur vainqueur
    winner.nbVictory += 1
        
    // Les stats de la partie sont affichés
    game.showStats(winner, looser)
        
    // Il est proposé aux joueurs de faire une nouvelle partie en gardant les mêmes noms de joueurs. Ensuite la boucle newGame est relancée et en fonction de la réponse, il sera poroposé de nommer les joueurs (dans ce cas le nombre de parties jouées repasse a 0) ou non (dans ce cas le nombre de parties jouées s'incrément de 1).
    game.askToKeepPlayerName()
//}
//}
