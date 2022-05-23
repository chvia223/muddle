//
//  BoardDataModel.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/20/22.
//

import Foundation
import SwiftUI

class GameBoard: ObservableObject {
    struct LetterThing: Codable, Hashable {
        var letter: String = ""
        var state = LetterState.unknown
    }
    
    var winningWord: String = "apple"
    

    @Published var board: [[LetterThing]] = {
        var rows = [[LetterThing]]()
        for _ in 0..<6 {
            var columns = [LetterThing]()
            for _ in 0..<5 {
                columns.append(LetterThing())
            }
            rows.append(columns)
        }
        return rows
    }()

    
    
    func nextOpenIndex() -> (Int, Int) {
        var wordIndex = 0
        var letterIndex = 0
        for word in self.board {
            for letter in word {
                if letter.state == LetterState.unknown {
                    return (wordIndex, letterIndex)
                }
                letterIndex += 1
            }
            wordIndex += 1
        }
        // This is returned if there are no unknowns on the board.
        // Something outside of this function will need to handle
        // this because it WILL throw an error if not accounted for.
        return (-1,-1)
    }
}







// As they type.
func modifyGuessOnBoard(gameBoard: GameBoard, newLetter: String) -> GameBoard {
    let availableIndex = gameBoard.nextOpenIndex()
    
    gameBoard.board[availableIndex.0][availableIndex.1].letter = newLetter
    gameBoard.board[availableIndex.0][availableIndex.1].state = .unconfirmedGuess
    
    return gameBoard
}

// Function needed as they delete.

func modifyBoardOnCommit(gameBoard: GameBoard) -> GameBoard {
    return gameBoard
}

//test Function
func testChangeLetterOnCommit(gameBoard: GameBoard) -> GameBoard {
    gameBoard.board[0][0].letter = "t"
    gameBoard.board[0][0].state = .rightLetterRightPlace
    
    gameBoard.board[0][1].letter = "e"
    gameBoard.board[0][1].state = .rightLetterWrongPlace
    
    gameBoard.board[0][2].letter = "s"
    gameBoard.board[0][2].state = .wrongLetterWrongPlace
    
    gameBoard.board[0][3].letter = "t"
    gameBoard.board[0][3].state = .rightLetterWrongPlace
    
    
    return gameBoard
}

enum LetterState: Codable {
    case unknown
    case unconfirmedGuess
    case wrongLetterWrongPlace
    case rightLetterWrongPlace
    case rightLetterRightPlace
}

extension LetterState {
    var color: Color {
        get {
            switch self {
            case .unknown:
                return .gray
            case .unconfirmedGuess:
                return .gray
            case .wrongLetterWrongPlace:
                return .red
            case .rightLetterWrongPlace:
                return .yellow
            case .rightLetterRightPlace:
                return .green
            }
        }
    }
}
