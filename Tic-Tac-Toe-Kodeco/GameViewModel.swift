//
//  GameViewModel.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import SwiftUI

extension GameView {
    final class GameViewModel: ObservableObject {

        var verticalSizeClass: UserInterfaceSizeClass?

        let itemCount = 3
        let horizontalPadding = 16.0
        let itemSpacing = 16.0
        let centerSquare = 4

        let navigationContentYOffset: CGFloat = -44

        @Published var moves: [Move?] = Array(repeating: nil, count: 9)
        @Published var isGameboardDisabled = false
        @Published var alertItem: AlertItem?

        var winner: Player?
        var columns: [GridItem] { Array(repeating: GridItem(.flexible(), spacing: itemSpacing), count: itemCount) }


        func processPlayerMove(for positionIndex: Int) {
            guard isSquareOccupied(in: moves, at: positionIndex) == false else {
                print("This space is already taken. Please try again.")
                return
            }

            moves[positionIndex] = Move(player: .human, boardIndex: positionIndex)

            if checkWinCondition(for: .human, in: moves) {
                print("Human wins")
                winner = .human
                alertItem = AlertContext.humanWin
                return
            }

            if checkForDraw(in: moves) {
                print("Draw")
                alertItem = AlertContext.draw
                return
            }

            isGameboardDisabled = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                guard let self else { return }

                let computerPosition = determineComputerMovePosition(in: moves)
                moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                isGameboardDisabled = false

                if checkWinCondition(for: .computer, in: moves) {
                    print("Computer wins")
                    winner = .computer
                    alertItem = AlertContext.computerWin
                    return
                }

                if checkForDraw(in: moves) {
                    print("Draw")
                    alertItem = AlertContext.draw
                    return
                }
            }
        }


        func calculateItemSize(from proxy: GeometryProxy) -> CGFloat {
            let adjustmentForSpacing = (itemSpacing * 2) + (horizontalPadding * 2)

            switch verticalSizeClass {
            case .compact:
                return (proxy.frame(in: .global).height - adjustmentForSpacing) / 3
            default:
                return (proxy.frame(in: .global).width - adjustmentForSpacing) / 3
            }
        }


        func isSquareOccupied(in moves: [Move?], at index: Int) -> Bool {
            moves.contains(where: { $0?.boardIndex == index })
        }


        func determineComputerMovePosition(in moves: [Move?]) -> Int {
            
            // If AI can win, then win
            let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

            let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
            let computerPositions = Set(computerMoves.map { $0.boardIndex })

            for pattern in winPatterns {
                let possibleWinPositions = pattern.subtracting(computerPositions)

                if possibleWinPositions.count == 1 {
                    if let firstPossibleWinPosition = possibleWinPositions.first {
                        let isAvailable = !isSquareOccupied(in: moves, at: firstPossibleWinPosition)

                        if isAvailable { return firstPossibleWinPosition }
                    }
                }
            }

            // If AI can't win, then block
            let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
            let humanPositions = Set(humanMoves.map { $0.boardIndex })

            for pattern in winPatterns {
                let possibleWinPositions = pattern.subtracting(humanPositions)

                if possibleWinPositions.count == 1 {
                    if let blockPosition = possibleWinPositions.first {
                        let isAvailable = !isSquareOccupied(in: moves, at: blockPosition)

                        if isAvailable { return blockPosition }
                    }
                }
            }

            // If AI can't block, then take middle square
            if !isSquareOccupied(in: moves, at: centerSquare) { return centerSquare }

            // if AI can't take middle square, take random available square
            var movePosition = Int.random(in: 0 ..< 9)

            while isSquareOccupied(in: moves, at: movePosition) {
                movePosition = Int.random(in: 0 ..< 9)
            }

            return movePosition
        }


        func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {

            let winPatterns: Set<Set<Int>> = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]

            let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
            let playerPositions = Set(playerMoves.map { $0.boardIndex })

            for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }

            return false
        }


        func checkForDraw(in moves: [Move?]) -> Bool {

//            Long hand version of filtering out nil moves to see if board is complete
//            var totalMoves = 0
//
//            for move in moves {
//                if move != nil {
//                    totalMoves += 1
//                }
//            }
//
//            return totalMoves == 9

            return moves.compactMap { $0 }.count == 9
        }

        
        func resetGame() {
            
            withAnimation { moves = Array(repeating: nil, count: 9) }
        }
    }
}
