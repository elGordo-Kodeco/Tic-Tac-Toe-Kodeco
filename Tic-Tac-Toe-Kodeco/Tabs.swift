//
//  Tabs.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/17/24.
//

import Foundation

// This is data for a tab
enum Tabs: Int, Identifiable {

    case game, stats

    var id: Tabs { self }
    var customizationID: String { description }

    var title: String {
        switch self {
        case .game:     "Play"
        case .stats:    "Stats"
        }
    }

    var icon: String {
        switch self {
        case .game:     "gamecontroller"
        case .stats:    "chart.bar"
        }
    }

    var description: String {
        switch self {
        case .game:     "GameView"
        case .stats:    "StatsView"
        }
    }
}


extension Tabs: CaseIterable {}
