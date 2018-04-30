//
//  Player.swift
//  TicTacToe
//
//  Created by Jessie on 2018-04-12.
//  Copyright © 2018 Jessie. All rights reserved.
//

import Foundation

class Player {
    var name: String! // Player's name in plain language
    var points: Int! // Accumulated game wins/points (code for future game)
    var piece: String! // X or O piece
    var ownedID: Block! // From "Block" class. Used to tell the block that it's owned by the player
    
    
    
    init () {
        
    }
    
    convenience init (playerName: String = "No player selected", playerPoints: Int = 0, playerPiece: String = "xPiece", ownerID: Block = Block.init(blockOwnedBy: "unassigned")) {
        
        self.init()
        name = playerName
        points = playerPoints
        piece = playerPiece
        ownedID = ownerID
        
    }
    
    
}
