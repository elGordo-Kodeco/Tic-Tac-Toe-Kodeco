//
//  GridItemView.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import SwiftUI

struct GridItemView: View {

    let viewModel: GameView.GameViewModel
    let proxy: GeometryProxy
    let moves: [Move?]?
    let index: Int

    private let indicatorSymbolSize: CGFloat = 42.0


    var body: some View {
        ZStack {
            if proxy.frame(in: .global).isEmpty == false {
                Circle()
                    .frame(
                        width: viewModel.calculateItemSize(from: proxy),
                        height: viewModel.calculateItemSize(from: proxy)
                    )
                    .foregroundStyle(.pink.opacity(0.5))

                if let moves, let indicatorSymbol = moves[index]?.indicatorSymbol {
                    Image(systemName: indicatorSymbol)
                        .resizable()
                        .symbolEffect(.pulse, value: moves.count)
                        .scaledToFit()
                        .frame(width: indicatorSymbolSize, height: indicatorSymbolSize)
                        .foregroundStyle(.white)
                        .bold()
                }
            }
        }
        .onTapGesture { viewModel.processPlayerMove(for: index) }
    }
}


#Preview {
    GeometryReader { proxy in
        GridItemView(
            viewModel: GameView.GameViewModel(),
            proxy: proxy,
            moves: [Move(player: .human, boardIndex: 0)],
            index: 0
        )
    }
}
