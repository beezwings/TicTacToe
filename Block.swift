//
//  Block.swift
//  TicTacToe
//
//  Created by Jessie on 2018-04-12.
//  Copyright © 2018 Jessie. All rights reserved.
//

import Foundation

class Block {
    var ownership: String? // This assigns whether a block is unassigned, owned by player, or owned by computer
    var square: Int? // This tells the block which tic tac toe square it is (1-9)
    
    
    init(blockOwnedBy: String = "unassigned", squareOccupied: Int = 0) {
        ownership = blockOwnedBy
        square = squareOccupied
        
    }
}
