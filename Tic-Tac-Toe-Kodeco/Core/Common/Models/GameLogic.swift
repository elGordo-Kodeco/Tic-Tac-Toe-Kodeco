//
//  GameLogic.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 11/4/24.
//

import Foundation

/// A utility structure that provides core game logic for the Tic-Tac-Toe game, including win and draw conditions.
///
/// `GameLogic` defines winning patterns and includes static methods for checking game outcomes. It helps determine
///  if a player has won,
/// if the game is a draw, and the potential winning position for a player in strategic scenarios.
struct GameLogic {

    /// A set of winning patterns for the Tic-Tac-Toe game, representing all possible ways a player can win.
    ///
    /// Each pattern is a set of `BoardIndex` values that, when matched by a player, constitute a win.
    static let winningPatterns: Set<Set<BoardIndex>> = [
        [BoardIndex(row: 0, column: 0), BoardIndex(row: 0, column: 1), BoardIndex(row: 0, column: 2)],
        [BoardIndex(row: 1, column: 0), BoardIndex(row: 1, column: 1), BoardIndex(row: 1, column: 2)],
        [BoardIndex(row: 2, column: 0), BoardIndex(row: 2, column: 1), BoardIndex(row: 2, column: 2)],
        [BoardIndex(row: 0, column: 0), BoardIndex(row: 1, column: 0), BoardIndex(row: 2, column: 0)],
        [BoardIndex(row: 0, column: 1), BoardIndex(row: 1, column: 1), BoardIndex(row: 2, column: 1)],
        [BoardIndex(row: 0, column: 2), BoardIndex(row: 1, column: 2), BoardIndex(row: 2, column: 2)],
        [BoardIndex(row: 0, column: 0), BoardIndex(row: 1, column: 1), BoardIndex(row: 2, column: 2)],
        [BoardIndex(row: 0, column: 2), BoardIndex(row: 1, column: 1), BoardIndex(row: 2, column: 0)]
    ]

    /// Checks if the specified player has achieved a winning combination.
    ///
    /// - Parameters:
    ///   - player: The player to check (either `.human` or `.computer`).
    ///   - moves: A dictionary of moves, keyed by `BoardIndex`, that represents the current state of the board.
    /// - Returns: `true` if the player has achieved a winning pattern, otherwise `false`.
    static func checkWinCondition(for player: Player, in moves: [BoardIndex: Move]) -> Bool {
        let playerMoves = moves.filter { $0.value.player == player }.keys
        for pattern in winningPatterns where pattern.isSubset(of: playerMoves) {
            return true
        }
        return false
    }

    /// Checks if the game has reached a draw state.
    ///
    /// A draw occurs when all board positions are filled, but no player has achieved a winning combination.
    ///
    /// - Parameter moves: A dictionary of moves that represents the current state of the board.
    /// - Returns: `true` if the game is a draw, otherwise `false`.
    static func checkForDraw(in moves: [BoardIndex: Move]) -> Bool {
        moves.count == 9
    }

    /// Finds a winning position for the specified player, if available.
    ///
    /// This function is used to identify if the player has an imminent winning move, returning the board position
    /// that would complete the winning pattern.
    ///
    /// - Parameters:
    ///   - player: The player for whom to find a winning position.
    ///   - moves: A dictionary of moves that represents the current state of the board.
    /// - Returns: The `BoardIndex` where the player can make a winning move, or `nil` if no such position exists.
    static func findWinningPosition(for player: Player, in moves: [BoardIndex: Move]) -> BoardIndex? {
        let playerMoves = moves.filter { $0.value.player == player }.keys
        for pattern in winningPatterns {
            let availablePositions = pattern.subtracting(playerMoves)
            if availablePositions.count == 1, let winPosition = availablePositions.first,
               moves[winPosition] == nil {
                return winPosition
            }
        }
        return nil
    }
}
