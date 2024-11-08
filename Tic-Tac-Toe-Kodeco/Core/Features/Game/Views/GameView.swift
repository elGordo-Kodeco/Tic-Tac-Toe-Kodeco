//
//  GameView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/10/24.
//

import SwiftUI

/// The main game view for the Tic-Tac-Toe-Kodeco app, displaying the Tic-Tac-Toe grid and handling user interactions.
///
/// `GameView` creates a 3x3 grid using `Grid` and `GridRow` components. Each cell in the grid is represented by a
/// `GridItemView` that displays
/// the current state of the game (e.g., player moves). The view model handles game logic, including managing
/// moves, tracking game state, and providing
/// alerts when a player wins or the game results in a draw.
///
/// - Properties:
///     - `verticalSizeClass`: An environment property that detects the vertical size class, used to adjust UI
///      elements based on screen orientation.
///     - `viewModel`: A state property holding the `GameViewModel`, which manages game state and interactions.
///
struct GameView: View {

    /// Environment property for detecting the vertical size class (e.g., `.compact` for landscape).
    @Environment(\.verticalSizeClass) private var verticalSizeClass

    /// The view model that manages the state of the game and handles game logic.
    @State private var viewModel = GameViewModel()

    var body: some View {
        Grid(horizontalSpacing: 16, verticalSpacing: 16) {
            ForEach(0 ..< 3) { rowIndex in // Creates 3 rows for the Tic-Tac-Toe grid
                GridRow {
                    ForEach(0 ..< 3) { columnIndex in // Creates 3 columns per row
                        GridItemView(
                            viewModel: viewModel,
                            boardIndex: BoardIndex(row: rowIndex, column: columnIndex)
                        )
                    }
                }
            }
        }
        .padding(.horizontal, viewModel.horizontalPadding)
        .offset(y: verticalSizeClass != .compact ? viewModel.navigationContentYOffset : .zero)
        .disabled(viewModel.isGameboardDisabled)
        .alert(item: $viewModel.alertItem) { $0.setAlert(action: viewModel.resetGame) }
        .navigationTitle("TicTacToe")
    }
}

#Preview {
    NavigationStack {
        GameView()
    }
}
