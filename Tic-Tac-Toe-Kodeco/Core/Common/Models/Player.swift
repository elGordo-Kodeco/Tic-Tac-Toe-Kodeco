//
//  Player.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import SwiftUI

/// Represents a player in the Tic-Tac-Toe game, either human or computer.
///
/// The `Player` enum identifies the two types of participants in the game. It conforms to `Codable`, allowing
/// player information to be encoded and decoded, which can be useful for saving game states or transmitting data.
///
/// - Cases:
///     - `human`: Represents a human player.
///     - `computer`: Represents the computer or AI player.
enum Player: Codable {

    case human
    case computer
}
