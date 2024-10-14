//
//  GameView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/10/24.
//

import SwiftUI

struct GameView: View {

    private let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16), count: 3)

    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(0 ..< 9) { item in
                    Circle()
                        .fill(.blue)
                }
            }
            .navigationTitle("Some title")
        }
    }
}

#Preview {
    GameView()
}





















//            Grid {
//                // These are our rows
//                ForEach(0 ..< 3) { item in
//                    GridRow {
//                        // These are our columns
//                        ForEach(0 ..< 3) { item in
//                            Circle()
//                                .fill(.red)
//                        }
//                    }
//                }
//            }
