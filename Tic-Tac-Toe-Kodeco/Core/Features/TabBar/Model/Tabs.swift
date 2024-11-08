//
//  Tabs.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/17/24.
//

import Foundation

/// Represents the available tabs in the Tic-Tac-Toe-Kodeco app, each with its own title, icon, and description.
///
/// `Tabs` conforms to `Identifiable` and `CaseIterable`, allowing it to be used in SwiftUI's `ForEach` loops
/// and providing a unique identifier for each case. Each tab includes properties for customization ID, title,
/// icon, and description.
enum Tabs: Int, Identifiable {

    /// The tab for the game screen.
    case game

    /// The tab for viewing statistics.
    case stats

    /// The unique identifier for each tab, required by the `Identifiable` protocol.
    var id: Tabs { self }

    /// A unique customization ID for each tab, derived from the tab’s description.
    var customizationID: String { description }

    /// The displayed title for each tab.
    ///
    /// - Returns: A string representing the title for the tab.
    var title: String {
        switch self {
        case .game:     "Play"
        case .stats:    "Stats"
        }
    }

    /// The system icon name for each tab.
    ///
    /// This icon is displayed alongside the tab title in the app's tab bar.
    /// - Returns: A string representing the system icon name.
    var icon: String {
        switch self {
        case .game:     "gamecontroller"
        case .stats:    "chart.bar"
        }
    }

    /// A description of each tab, used for accessibility and customization.
    ///
    /// - Returns: A string providing a description of the tab's functionality.
    var description: String {
        switch self {
        case .game:     "GameView"
        case .stats:    "StatsView"
        }
    }
}

// Extending `Tabs` to conform to `CaseIterable`, allowing iteration over all available tabs.
extension Tabs: CaseIterable {}
