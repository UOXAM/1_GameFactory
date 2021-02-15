//
//  main.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

//  ****************************************************
//          AVANT DE JOUEUR : VARIABLES
//  ****************************************************

var nbGames: Int
var game = Game()
var play = true
var activePlayer = game.playerOne
var passivePlayer = game.playerTwo

//  ****************************************************
//          ON PROPOSE EN BOUCLE DE JOUER AU JEU
//  ****************************************************

while play == true{
    
    // ----------------------------------------------------------------------------
    // INITIALISE LE JEU : DEMANDER DE JOUER, NOMMER LES JOUEURS, CRÉER LES ÉQUIPES
    // ----------------------------------------------------------------------------
    game.initialisation()
        
    // ----------------------------------------------------------------------------
    // LANCE LE JEU : CHAQUE TOUR LES JOUEURS JOUENT À LA SUITE TANT QU'IL RESTE
    //           AU MOINS UN PERSONNAGE VIVANT DANS CHAQUE TEAM
    // ----------------------------------------------------------------------------
    game.play()
        
    // ----------------------------------------------------------------------------
    // FINALISATION : A LA FIN DE CHAQUE PARTIE ON AFFICHE LES STATS ET ON PROPOSE
    //              DE REJOUER EN GARDANT LES MÊMES NOMS DE JOUEURS
    // ----------------------------------------------------------------------------
    game.finalisation()
}
