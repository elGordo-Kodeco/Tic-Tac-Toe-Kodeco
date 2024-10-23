//
//  Move.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import Foundation

struct Move: Codable {
    
    let player: Player
    let boardIndex: Int

    var indicatorSymbol: String { player == .human ? "xmark" : "circle" }
}
