//
//  BoardIndex.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 11/4/24.
//

import Foundation

/// Represents a position on the Tic-Tac-Toe game board, defined by row and column indices.
///
/// `BoardIndex` is used to identify specific cells within the game grid and is compatible with
///  collections requiring hashing,
/// making it ideal for use in dictionaries or sets where each position must be unique.
///
/// - Properties:
///     - `row`: The row index of the position on the game board (0, 1, or 2 for a 3x3 grid).
///     - `column`: The column index of the position on the game board (0, 1, or 2 for a 3x3 grid).
///
/// - Conformance:
///     - `Codable`: Allows `BoardIndex` to be encoded and decoded, useful for saving game state.
///     - `Hashable`: Enables use in sets or as dictionary keys, ensuring uniqueness of each board position.
struct BoardIndex: Codable, Hashable {

    /// The row index of the position on the game board (0, 1, or 2).
    let row: Int

    /// The column index of the position on the game board (0, 1, or 2).
    let column: Int
}
