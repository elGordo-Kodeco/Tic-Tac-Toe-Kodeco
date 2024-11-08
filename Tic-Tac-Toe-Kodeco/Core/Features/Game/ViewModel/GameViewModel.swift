//
//  GameViewModel.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import SwiftUI

extension GameView {

    /// The view model responsible for managing the game state and handling game logic.
    ///
    /// `GameViewModel` tracks player moves, determines when the game has been won or drawn, and manages
    /// interactions between the player and the AI opponent. It also controls when the game board is disabled
    /// and provides alert items when the game concludes.
    ///
    /// - Properties:
    ///     - `itemCount`: The number of items in each row or column of the grid (3 for a 3x3 Tic-Tac-Toe board).
    ///     - `horizontalPadding`: Horizontal padding for the game board.
    ///     - `itemSpacing`: Spacing between items on the game grid.
    ///     - `navigationContentYOffset`: Offset for the navigation content.
    ///     - `moves`: A dictionary tracking moves made by the player and AI, keyed by `BoardIndex`.
    ///     - `isGameboardDisabled`: Boolean indicating if the game board is currently interactable.
    ///     - `winner`: The player who has won the game, if any.
    ///     - `alertItem`: An alert configuration used to show game results.
    ///
    @Observable
    final class GameViewModel {

        /// The number of items in a row or column on the game board.
        let itemCount = 3

        /// The horizontal padding applied to the game grid.
        let horizontalPadding = 16.0

        /// The spacing between grid items.
        let itemSpacing = 16.0

        /// The vertical offset applied to adjust navigation content.
        let navigationContentYOffset: CGFloat = -44

        /// Dictionary tracking moves for each board position, keyed by `BoardIndex`.
        var moves: [BoardIndex: Move] = [:]

        /// A Boolean that disables the game board when the AI is processing a move.
        var isGameboardDisabled = false

        /// The player who won the game, if applicable.
        var winner: Player?

        /// An alert item to display when a game result is reached.
        var alertItem: AlertItem?

        /// An instance of `AIDecision` used for determining AI moves.
        private let aiDecision = AIDecision()

        /// Defines the grid layout for the game board, with flexible spacing based on `itemSpacing`.
        var columns: [GridItem] {
            Array(repeating: GridItem(.flexible(), spacing: itemSpacing), count: itemCount)
        }

        // MARK: - Game Logic

        /// Processes a player's move at the specified board position.
        ///
        /// Checks for a win or draw condition after the move, and if no end condition is met,
        /// disables the game board temporarily to allow the AI to make a move.
        ///
        /// - Parameter position: The `BoardIndex` where the player is attempting to make a move.
        func processPlayerMove(for position: BoardIndex) {
            guard moves[position] == nil else {
                print("This space is already taken. Please try again.")
                return
            }

            moves[position] = Move(player: .human, boardIndex: position)

            if GameLogic.checkWinCondition(for: .human, in: moves) {
                winner = .human
                alertItem = AlertContext.humanWin
                return
            }

            if GameLogic.checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }

            isGameboardDisabled = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                guard let self = self else { return }

                let computerPosition = self.aiDecision.determineMove(for: .computer, with: self.moves)
                self.moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                self.isGameboardDisabled = false

                if GameLogic.checkWinCondition(for: .computer, in: self.moves) {
                    self.winner = .computer
                    self.alertItem = AlertContext.computerWin
                    return
                }

                if GameLogic.checkForDraw(in: self.moves) {
                    self.alertItem = AlertContext.draw
                    return
                }
            }
        }

        /// Resets the game by clearing all moves, allowing a new game to be played.
        ///
        /// This method is typically called when a game ends and the user chooses to play again.
        func resetGame() {
            moves.removeAll()
        }
    }
}
