//
//  main.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

///
///
/// PROPOSER DE LANCER UNE PARTIE  
///
///

var playGame: Bool = false
func askToPlay(){
    print("Voulez-vous jouer ? oui ou non ?")

    // Tant que la réponse n'est pas "oui", reproposer de jouer
    while playGame == false {
        if let responseToPlay = readLine(){
    
    // Si la réponse est oui, lancer une partie
            if responseToPlay == "oui"{
                playGame = true
                play()
            }else if responseToPlay == "non"{
                print("Dommage... Vous êtes sûr... Voulez-vous jouer ? oui ou non ?")
            
            }else{
                print("Je ne comprends pas votre réponse")
            }
        }
    }
}

///
///
/// LANCER UNE PARTIE
///
///

func play(){
    print("C'est partit !")
        
    // Initialiser le jeu :
    let game = Game()
    var activePlayer = game.playerOne
    var passivePlayer = game.playerTwo

    //  Renseigner le nom des joueurs
    game.namePlayers()

    //  Créer les équipes et nommer ses personnages
    game.createTeam(activePlayer)
    game.createTeam(passivePlayer)

    //  Démarrer le jeu : Jouer à tour de rôle tant qu'au moins un personnage de chaque équipe est vivant
    while activePlayer.teamActualHealth > 0 && passivePlayer.teamActualHealth > 0 {
            
        //  Le Joueur choisit le personnage actif
        game.selectCharacterOfMyTeam(activePlayer)
            
        //  Proposer le coffre d'armes ?
        game.showChest()
            
        //   Si oui :
        if game.proposeChest == true{
            print("Un coffre contenant une armé aléatoire vous est proposé. Si vous l'ouvrez votre personnage devra prendre cette nouvelle arme.")
            print("Voulez vous ouvrir ce coffre ? oui ou non ?")

            //   Le Joueur décide d'ouvrir le coffre ?
            if let responseToOpenChest = readLine(){
                    
                //   Si oui : son personnage change d'arme
                if responseToOpenChest == "oui"{
                    game.randomWeapon()
                    if game.newWeapon.damages >= game.activeCharacter.weapon.damages{
                        print("Bonne pioche !")
                    }else{
                        print("Dommage !")
                    }
                    print("La nouvelle arme de \(game.activeCharacter.name) est \(game.newWeapon.name) avec \(game.newWeapon.damages) points de dégât.")
                    game.activeCharacter.weapon = game.newWeapon
                        
                //  Si non : on continue le jeu
                }else{
                    print("Ok, une prochaine fois peut être. Continuons le jeu.")
                }
            }
        }

        //  Choisir l'action ainsi que le personnage récepteur
        activePlayer.chooseAction()
            
        //  Recalculer la vie cumulée de chaque équipe
        activePlayer.calculateTeamStats()
        passivePlayer.calculateTeamStats()
            
        // Si l'adversaire a encore des personnages vivants : c'est à son tour de jouer
        if passivePlayer.teamActualHealth > 0{
            activePlayer = passivePlayer
            if activePlayer.name == game.playerOne.name {
                passivePlayer = game.playerTwo
            }else{
                passivePlayer = game.playerOne
            }
        }
    }

    // Si l'adversaire a perdu (tous ses personnages sont morts) : on arrête la partie et on montre les stats
    game.showStats()

}

///
///
/// PROPOSER DE REJOUER UNE PARTIE
///
///

print("Voulez vous rejouer en gardant les mêmes noms de joueurs ? oui ou non ?")
if let responseToPlayAgain = readLine(){
    
    // Avec les mêmes noms de Joueurs
    if responseToPlayAgain == "oui"{
        playGame = true
        play()
    
    // En recommençant depuis le début
    }else{
        askToPlay()
    }
}














