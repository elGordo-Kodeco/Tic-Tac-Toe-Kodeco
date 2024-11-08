//
//  AppTabView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/10/24.
//

import SwiftUI

/// The main tab view for the Tic-Tac-Toe-Kodeco app, offering two different tab configurations depending
///  on the iOS version.
///
/// This view switches between a modern tab interface for iOS 18.0 and later and a legacy tab view for iOS 17 and below.
///
/// - Version History:
///     - iOS 18.0+: Uses `Tab(value:role:)` for a modern tab interface with customization options.
///     - iOS 17 and below: Uses `tabItem` with tags to support earlier versions.
/// - Note: This view uses `SceneStorage` to persist the currently selected tab across app sessions.
///
struct AppTabView: View {

    /// The currently selected tab, stored in SceneStorage for persistence across app sessions.
    @SceneStorage("selectedTab") private var selectedTab: Tabs = Tabs.game

    var body: some View {
        if #available(iOS 18.0, *) {
            tabView
        } else {
            // Fallback for iOS 17 and below
            legacyTabView
        }
    }

    // MARK: - View Management

    /// Provides the view corresponding to a given tab.
    ///
    /// - Parameter tab: The specific tab selected.
    /// - Returns: A SwiftUI view that corresponds to the specified tab.
    @ViewBuilder
    private func view(for tab: Tabs) -> some View {
        switch tab {
        case .game:     GameView()
        case .stats:    StatsView()
        }
    }

    /// Provides the label view for a specified tab, including its title and icon.
    ///
    /// The label includes accessibility support, with an accessible description provided for each tab.
    ///
    /// - Parameter tab: The tab for which the label is created.
    /// - Returns: A label view containing the tab’s title and icon.
    private func label(for tab: Tabs) -> some View {
        Label {
            Text(tab.title).accessibilityLabel(tab.description)
        } icon: {
            Image(systemName: tab.icon)
                .environment(\.symbolVariants, selectedTab == tab ? .fill : .none)
        }
    }

    // MARK: - Tab Views

    /// The primary tab view for iOS 18.0 and later.
    ///
    /// Uses the new `Tab(value:role:)` initializer, allowing modern tab customization options. Each tab is
    /// associated with a specific view and customization role.
    ///
    /// - Available: iOS 18.0+
    @available(iOS 18.0, *)
    private var tabView: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases) { tab in
                Tab(value: tab.id) {
                    NavigationStack { view(for: tab) }
                } label: {
                    label(for: tab)
                }
                .customizationID(tab.customizationID)
            }
        }
    }

    /// The fallback tab view for iOS 17 and below.
    ///
    /// Uses the traditional `tabItem` approach with a tag to support earlier versions.
    private var legacyTabView: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases) { tab in
                NavigationStack { view(for: tab) }
                    .tabItem { label(for: tab) }
                    .tag(tab.customizationID)
            }
        }
    }
}

#Preview {
    AppTabView()
}
