//
//  AppTabView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/10/24.
//

import SwiftUI

struct AppTabView: View {

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

    /// Returns the view for the selected tab.
    ///
    /// - Parameter tab: The tab for which the view is being created.
    /// - Returns: A SwiftUI view corresponding to the specified tab.
    @ViewBuilder
    private func view(for tab: Tabs) -> some View {

        switch tab {
        case .game:     GameView()
        case .stats:    StatsView()
        }
    }

    /// Returns the label for the specified tab.
    ///
    /// This includes the title and accessibility label.
    ///
    /// - Parameter tab: The tab for which the label is being created.
    /// - Returns: A SwiftUI label view for the specified tab.
    private func label(for tab: Tabs) -> some View {

        Label { Text(tab.title).accessibilityLabel(tab.description) } icon: {
            Image(systemName: tab.icon)
                .environment(\.symbolVariants, selectedTab == tab ? .fill : .none)
        }
    }

    // MARK: - Tab Views

    /// The tab view for iOS 18.0 and later, using the modern tab interface.
    ///
    /// Each tab is associated with a specific view and role.
    /// This method uses the new `Tab(value:role:)` initializer.
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

    /// The legacy tab view for iOS 17 and below.
    ///
    /// This version uses the traditional `tabItem` approach.
    private var legacyTabView: some View {
        TabView(selection: $selectedTab) {
            ForEach(Tabs.allCases) { tab in
                NavigationStack { view(for: tab) }
                    .tabItem { label(for: tab) }
                    .tag(tab.customizationID) // Customization ID serves as the tag.
            }
        }
    }
}

#Preview {
    AppTabView()
}
