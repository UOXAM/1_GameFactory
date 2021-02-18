//
//  main.swift
//  Project_3
//
//  Created by ROUX Maxime on 30/01/2021.
//

import Foundation

//  ****************************************************
//          BEFORE THE GAME : VARIABLES
//  ****************************************************

var nbGames: Int
var game = Game()
var play = true
var activePlayer = game.playerOne
var passivePlayer = game.playerTwo

//  ****************************************************
//          WE PROPOSE TO PLAY THE GAME (LOOP)
//  ****************************************************

while play == true{
    
    // ----------------------------------------------------------------------------
    // INITIALIZE GAME : ASK TO PLAY DE JOUER, NAME CHARACTERS, CREATE TEAM
    // ----------------------------------------------------------------------------
    game.initialisation()
        
    // ----------------------------------------------------------------------------
    //              START THE GAME : EACH TURN BOTH PLAYERS PLAY
    //            WHILE BOTH TEAMS HAVE AT LEAST ONE CHARACTER ALIVE
    // ----------------------------------------------------------------------------
    game.play()
        
    // ----------------------------------------------------------------------------
    // FINALIZATION : AT THE END OF THE GAME THE STATS ARE DISPLAYED AND
    // WE ASK TO PLAY AGAIN WHILE KEEPING THE SAME PLAYER NAMES
    // ----------------------------------------------------------------------------
    game.finalisation()
}
