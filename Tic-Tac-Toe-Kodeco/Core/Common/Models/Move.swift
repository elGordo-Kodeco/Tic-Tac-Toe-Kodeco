//
//  Move.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import Foundation

/// Represents a single move made in the Tic-Tac-Toe game, including the player and position on the board.
///
/// `Move` is a simple data structure that holds information about which player made the move and where
///  it was placed on the game board.
/// It includes an `indicatorSymbol` property that returns the appropriate symbol for display in the UI.
///
/// - Properties:
///     - `player`: The player who made the move, either `.human` or `.computer`.
///     - `boardIndex`: The position on the game board where the move was made.
///     - `indicatorSymbol`: A computed property that returns the appropriate symbol ("xmark" for
///     human, "circle" for computer).
///
struct Move: Codable {

    /// The player who made this move.
    let player: Player

    /// The index on the game board where the move was placed.
    let boardIndex: BoardIndex

    /// The symbol used to represent this move in the UI.
    ///
    /// Returns "xmark" if the move was made by the human player, or "circle" if made by the computer.
    var indicatorSymbol: String {
        player == .human ? "xmark" : "circle"
    }
}
