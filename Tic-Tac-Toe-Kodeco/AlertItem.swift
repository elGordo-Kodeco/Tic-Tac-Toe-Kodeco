//
//  AlertItem.swift
//  Tic-Tac-Toe-Kodeco
//
//  Created by Christopher J. Roura on 10/21/24.
//

import SwiftUI

struct AlertItem: Identifiable {
    
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text


    func setAlert(action: (() -> Void)? = nil) -> Alert {
        Alert(title: title, message: message, dismissButton: .default(buttonTitle, action: action))
    }
}


struct AlertContext {

    static let humanWin = AlertItem(title: Text("You win"), message: Text("You beat your own AI."), buttonTitle: Text("Oh yeah!"))
    static let computerWin = AlertItem(title: Text("You lose"), message: Text("You got beat by your own AI."), buttonTitle: Text("Get revenge now!"))
    static let draw = AlertItem(title: Text("Oh snap"), message: Text("You tied with your own AI."), buttonTitle: Text("Try again?"))
}
