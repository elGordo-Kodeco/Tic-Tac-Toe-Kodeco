//
//  StatsView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/10/24.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        List(0 ..< 5) { item in
            Text("Placeholder text")
        }
        .navigationTitle("Stats View")
    }
}


#Preview {
    NavigationStack {
        StatsView()
    }
}
