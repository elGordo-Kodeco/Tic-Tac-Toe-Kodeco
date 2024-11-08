//
//  GridItemView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 11/7/24.
//

import SwiftUI

/// A view that represents a single cell in the Tic-Tac-Toe game grid.
///
/// `GridItemView` displays either a blank cell or an indicator symbol (e.g., "X" or "O") if a move has been made at
/// the specified `boardIndex`.
/// The cell responds to tap gestures, triggering the move processing in the view model.
///
/// - Parameters:
///     - viewModel: The view model managing game state and moves.
///     - boardIndex: The specific index in the game board that this view represents.
///
struct GridItemView: View {

    /// The view model that manages the state of the game, including player moves and game logic.
    @Bindable var viewModel: GameView.GameViewModel

    /// The index in the game board array that this view represents.
    let boardIndex: BoardIndex

    /// The size of the indicator symbol shown when a move is made.
    private let indicatorSymbolSize: CGFloat = 42.0

    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.pink.opacity(0.5)) // Background for the cell

            // Display the move indicator if a move has been made at this index
            if let move = viewModel.moves[boardIndex] {
                Image(systemName: move.indicatorSymbol)
                    .resizable()
                    .scaledToFit()
                    .frame(width: indicatorSymbolSize, height: indicatorSymbolSize)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
        .onTapGesture {
            viewModel.processPlayerMove(for: boardIndex)
        }
    }
}

#Preview {
    GridItemView(viewModel: GameView.GameViewModel(), boardIndex: BoardIndex(row: 1, column: 1))
}
