//
//  GameView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by RouraIndustries on 10/10/24.
//

import SwiftUI

struct GameView: View {

    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @StateObject private var viewModel = GameViewModel()

    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()

                LazyVGrid(columns: viewModel.columns, spacing: viewModel.itemSpacing) {
                    ForEach(0 ..< 9, id: \.self) { index in
                        GridItemView(
                            viewModel: viewModel,
                            proxy: proxy,
                            moves: viewModel.moves,
                            index: index
                        )
                    }
                }
                .padding(.horizontal, viewModel.horizontalPadding)
                .offset(y: verticalSizeClass != .compact ? viewModel.navigationContentYOffset : .zero)

                Spacer()
            }
            .disabled(viewModel.isGameboardDisabled)
            .alert(item: $viewModel.alertItem) {
                Alert(title: $0.title, message: $0.message, dismissButton: .default($0.buttonTitle, action: viewModel.resetGame))
            }
        }
        .navigationTitle("TicTacToe")
    }
}


#Preview {
    NavigationStack {
        GameView()
    }
}
