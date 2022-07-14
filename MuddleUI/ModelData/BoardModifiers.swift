//
//  BoardModifiers.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/26/22.
//

import Foundation


///  Returns a new GameBoard struct if the original has been modified. Otherwise the original
///  will be returned.

///  Receives a GameBoard struct and a String as parameters. If there is an open spot in the currently
///  attempted guess then the passed in String will populate the next available spot in the GameBoard's
///  guess. If all five letters have already been filled then the passed in String will be ignored and the
///  GameBoard won't be changed.
func addLetterToGuess(gameBoard: GameBoard, newLetter: String) -> GameBoard {
    
    let availableIndex = gameBoard.nextOpenIndex()
    
    guard availableIndex != (-1,-1) else {
        return gameBoard
    }
        
    var newBoard = gameBoard
        
    newBoard.board[availableIndex.0][availableIndex.1].letter = newLetter
    newBoard.board[availableIndex.0][availableIndex.1].state = .unconfirmedGuess
        
    return newBoard
}
  


///  Returns a new GameBoard struct.
///
///  Receives a GameBoard struct as a parameter. The last guess index modified by a
///  letter key is changed to an empty string. If there are no more unconfirmed letters left in the guess
///  then the first index of the guess is just repeatedly replaced with an empty string even if it already
///  has one.
func deleteLetterFromGuess(gameBoard: GameBoard) -> GameBoard {
    
    if gameBoard.compareGuessToSolution() {
        return gameBoard
    }
    
    let availableIndex = gameBoard.lastEnteredIndex()
    
    var newBoard = gameBoard
    
    newBoard.board[availableIndex.0][availableIndex.1].letter = ""
    newBoard.board[availableIndex.0][availableIndex.1].state = .unknown
    
    return newBoard
}



///  Returns a new GameBoard struct if the original has been modified. Otherwise the original
///  will be returned.

///  Receives a GameBoard struct as a parameter. There's honestly too much going on here,
///  but it works so I'm not going to touch it for a while. The first that will be checked is if all five
///  spots in the guess are filled. If they are not then the original GameBoard is returned.
///  Otherwise each letter in the guess will be compared against each letter in the solution
///  through a series of loops and the state stored in each guess letter will be modified as each
///  loop checks for.
///
///
///  (Commentary)
///
///  So the last implementation of this code was actually wrong and didn't work right. And on top
///  of all of that it was inefficient for what it was. I can't believe I thought a nested for loop was
///  completely necessary. Though that might be what's happening during that .contains call in the
///  second for loop. Either way, this works much better now and is much less ugly. Like waaaaay
///  less ugly. Thank guard!
func commitGuess(gameBoard: GameBoard) -> GameBoard {
    
    guard gameBoard.lastEnteredIndex().1 == 4 && gameBoard.hasValidWord else {
        return gameBoard
    }
    
    
    var newBoard = gameBoard
    var solution = newBoard.solution
    let line = newBoard.currentGuess
    
    
    for (guessIndex, element) in newBoard.board[line].enumerated()
    where element.letter.lowercased() == solution[guessIndex] {
        newBoard.board[line][guessIndex].state = .rightLetterRightPlace
        solution[guessIndex] = ""
    }
    
    for (guessIndex, element) in newBoard.board[line].enumerated() {
        guard let firstElementIndex = solution.firstIndex(of: element.letter.lowercased()) else {
            continue
        }
        if newBoard.board[line][guessIndex].state == .unconfirmedGuess {
            newBoard.board[line][guessIndex].state = .rightLetterWrongPlace
            solution[firstElementIndex] = ""
        }
    }
    
    for (guessIndex, element) in newBoard.board[line].enumerated()
    where element.state == .unconfirmedGuess {
        newBoard.board[line][guessIndex].state = .wrongLetterWrongPlace
    }
    
    
    // Temp code anyways. In the future there'll either be an alert
    // or sheet that displays the end condition message. For now this
    // text will have to do.
    if newBoard.compareGuessToSolution() {
        newBoard.winMessage = "You won!"
    } else {
        if gameBoard.currentGuess == 5 {
            newBoard.winMessage = "You lose 😔"
        } else {
            newBoard.currentGuess += 1
        }
    }
    
    return newBoard
}
