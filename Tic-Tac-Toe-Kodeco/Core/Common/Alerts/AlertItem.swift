//
//  AlertItem.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import SwiftUI

/// Represents an alert in the Tic-Tac-Toe game, with customizable title, message, and button title.
///
/// `AlertItem` is designed to create consistent, identifiable alerts for game outcomes, such as wins, losses, or draws.
/// Each alert has a unique identifier to support SwiftUI’s `Identifiable` protocol and can trigger an optional action
/// when dismissed.
///
/// - Properties:
///     - `id`: A unique identifier for the alert, used for conforming to `Identifiable`.
///     - `title`: The title text displayed at the top of the alert.
///     - `message`: The message text providing additional details in the alert.
///     - `buttonTitle`: The title of the button that dismisses the alert.
/// - Methods:
///     - `setAlert(action:)`: Generates a SwiftUI `Alert` with the specified properties and an optional
///      dismissal action.
struct AlertItem: Identifiable {

    /// A unique identifier for the alert, allowing SwiftUI to manage alert presentation.
    let id = UUID()

    /// The title text displayed at the top of the alert.
    var title: Text

    /// The message text providing details within the alert.
    var message: Text

    /// The title of the button that dismisses the alert.
    var buttonTitle: Text

    /// Creates a SwiftUI `Alert` with the specified title, message, and dismiss button.
    ///
    /// - Parameter action: An optional closure to execute when the alert's dismiss button is tapped.
    /// - Returns: A configured `Alert` instance with the provided title, message, and button action.
    func setAlert(action: (() -> Void)? = nil) -> Alert {
        Alert(title: title, message: message, dismissButton: .default(buttonTitle, action: action))
    }
}

/// Provides predefined alerts for game outcomes, including win, lose, and draw scenarios.
///
/// `AlertContext` defines static instances of `AlertItem` for consistent usage across the game,
/// allowing easy access to alert configurations for different game results.
struct AlertContext {

    /// Alert item for when the human player wins the game.
    static let humanWin = AlertItem(
        title: Text("You win"),
        message: Text("You beat your own AI."),
        buttonTitle: Text("Oh yeah!")
    )

    /// Alert item for when the computer wins the game.
    static let computerWin = AlertItem(
        title: Text("You lose"),
        message: Text("You got beat by your own AI."),
        buttonTitle: Text("Get revenge now!")
    )

    /// Alert item for when the game results in a draw.
    static let draw = AlertItem(
        title: Text("Oh snap"),
        message: Text("You tied with your own AI."),
        buttonTitle: Text("Try again?")
    )
}
