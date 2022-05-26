//
//  ContentView.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/17/22.
//
//  Test Comment

import SwiftUI


struct ContentView: View {
    @State var gameBoard = GameBoard()
    @State var singleLetter: String = "x"
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                Spacer() 
                VStack {
                    ForEach(gameBoard.board.indices, id: \.self) { i in
                        let row = gameBoard.board[i]
                        HStack {
                            ForEach(row.indices, id: \.self) { j in
                                LetterBox(displayedLetter: row[j].letter, boxColor: row[j].state.color)
                            }
                        }
                    }
                }
                .padding()
                
                KeyboardView() { key in
                    switch (key) {
                    case .enter:
                        gameBoard = testChangeLetterOnCommit(gameBoard: gameBoard)
                        
                    case .delete:
                        print("Pressed delete")
                        
                    case .letter(let keyLetter):
                        print("Pressed \(keyLetter)")
                        
                    }
                }
                .frame(width: screen.size.width, height: screen.size.height * 0.30)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
