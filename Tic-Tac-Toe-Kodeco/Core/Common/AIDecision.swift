//
//  AIDecision.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 11/4/24.
//

import Foundation

/// Handles the AI decision-making process for the Tic-Tac-Toe game.
///
/// `AIDecision` provides a method for determining the AI's next move based on a prioritized strategy:
/// 1. Attempt to win if possible.
/// 2. Block the opponent from winning if they have an imminent victory.
/// 3. Take the center square if it is available.
/// 4. Take one of the corners if available.
/// 5. Take any other available square if no preferred options are open.
struct AIDecision {

    /// The index representing the center square of the Tic-Tac-Toe board.
    private let centerSquare = BoardIndex(row: 1, column: 1)

    /// The indices representing the four corner squares of the Tic-Tac-Toe board.
    private let cornerSquares = [
        BoardIndex(row: 0, column: 0), BoardIndex(row: 0, column: 2),
        BoardIndex(row: 2, column: 0), BoardIndex(row: 2, column: 2)
    ]

    /// Determines the optimal move for the AI player based on the current state of the game board.
    ///
    /// This method applies a sequence of prioritized checks to select the AI's move:
    /// - **Winning Move**: If the AI has a winning move available, it will choose that move.
    /// - **Blocking Move**: If the opponent has a winning move available, the AI will block it.
    /// - **Center Move**: If neither player is about to win, the AI will choose the center if available.
    /// - **Corner Move**: If the center is taken, the AI will select one of the corners.
    /// - **Random Move**: If no specific move is preferable, the AI will choose a random available square.
    ///
    /// - Parameters:
    ///   - player: The AI player (`Player.computer`) making the move.
    ///   - moves: A dictionary of moves made on the board, keyed by `BoardIndex`.
    /// - Returns: The `BoardIndex` where the AI should make its move.
    func determineMove(for player: Player, with moves: [BoardIndex: Move]) -> BoardIndex {

        // 1. Win if possible
        if let winPosition = GameLogic.findWinningPosition(for: player, in: moves) {
            return winPosition
        }

        // 2. Block if opponent can win
        let opponent: Player = player == .human ? .computer : .human
        if let blockPosition = GameLogic.findWinningPosition(for: opponent, in: moves) {
            return blockPosition
        }

        // 3. Take center
        if moves[centerSquare] == nil {
            return centerSquare
        }

        // 4. Take a corner
        if let availableCorner = cornerSquares.first(where: { moves[$0] == nil }) {
            return availableCorner
        }

        // 5. Take any available square
        return chooseRandomAvailablePosition(in: moves)
    }

    /// Selects a random available position on the game board if no preferred move is found.
    ///
    /// - Parameter moves: A dictionary of current moves on the board, keyed by `BoardIndex`.
    /// - Returns: A randomly chosen `BoardIndex` from the available positions, or the center square as a fallback.
    private func chooseRandomAvailablePosition(in moves: [BoardIndex: Move]) -> BoardIndex {
        let allPositions = [
            BoardIndex(row: 0, column: 0), BoardIndex(row: 0, column: 1), BoardIndex(row: 0, column: 2),
            BoardIndex(row: 1, column: 0), BoardIndex(row: 1, column: 1), BoardIndex(row: 1, column: 2),
            BoardIndex(row: 2, column: 0), BoardIndex(row: 2, column: 1), BoardIndex(row: 2, column: 2)
        ]
        let availablePositions = allPositions.filter { moves[$0] == nil }
        return availablePositions.randomElement() ?? centerSquare
    }
}
