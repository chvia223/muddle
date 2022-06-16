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
                
                Text(gameBoard.winMessage)
                
                KeyboardView() { key in
                    switch (key) {
                    case .enter:
                        gameBoard = commitGuess(gameBoard: gameBoard)
                        
                    case .delete:
                        gameBoard = deleteLetterFromGuess(gameBoard: gameBoard)
                        
                    case .letter(let keyLetter):
                        gameBoard = addLetterToGuess(gameBoard: gameBoard, newLetter: keyLetter)
                    }
                }
                .frame(width: screen.size.width, height: screen.size.height * 0.30)
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
