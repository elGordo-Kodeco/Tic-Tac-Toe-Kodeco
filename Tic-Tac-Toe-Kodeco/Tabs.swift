//
//  Tabs.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/14/24.
//

import Foundation

enum Tabs: Int, Identifiable, CaseIterable {

    case game, stats

    var id: Self { self }
    var customizationID: String { description }

    var title: LocalizedStringResource {
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
