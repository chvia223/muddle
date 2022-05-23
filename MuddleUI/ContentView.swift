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
        VStack {
            ForEach(gameBoard.board.indices, id: \.self) { i in
                let row = gameBoard.board[i]
                HStack {
                    ForEach(row.indices, id: \.self) { j in
                        LetterBox(displayedLetter: row[j].letter, boxColor: row[j].state.color)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                
            }
            
            HStack {
                
            }
            
            HStack {
                
            }
            
            Button("Press Me") {
                gameBoard = testChangeLetterOnCommit(gameBoard: gameBoard)
                print(gameBoard.board[0][0].letter, gameBoard.board[0][1].letter, gameBoard.board[0][2].letter, gameBoard.board[0][3].letter)
                singleLetter = "k"
            }
            Text(singleLetter)
        }
        .padding()
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
