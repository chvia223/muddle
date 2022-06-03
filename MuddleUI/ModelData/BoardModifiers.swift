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
    
    let availableIndex = gameBoard.lastEnteredIndex()
    
    var newBoard = gameBoard
    
    newBoard.board[availableIndex.0][availableIndex.1].letter = ""
    newBoard.board[availableIndex.0][availableIndex.1].state = .unknown
    
    return newBoard
}



///  Returns a Bool.

///  Receives a GameBoard struct as a parameter. This function will iterate through each stored
///  letter in the current guess and check that it's state is the right letter in the right place. If each
///  of the five letters holds that state then True will be returned. Otherwise False will be returned.
func compareCommitToWinWord(gameBoard: GameBoard) -> Bool {
    
    for letter in gameBoard.board[gameBoard.currentGuess] {
        if letter.state != .rightLetterRightPlace {
            return false
        }
    }
    
    return true
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
///  Honestly, the yuckiest part of all of this code is making sure extra of the same letter don't
///  get colored. That way the player knows how many of each lettter there are in the correct
///  word. We just replaced the character with an empty string when we found it so it wouldn't
///  be compared against again for this comparison call.
func commitGuess(gameBoard: GameBoard) -> GameBoard {
    
    var newBoard = gameBoard
    var solution = newBoard.solution
    let line = newBoard.currentGuess
    
    if gameBoard.lastEnteredIndex().1 == 4 {
        
        for (guessIndex, element) in newBoard.board[newBoard.currentGuess].enumerated() {
            var shouldContinue = false
            
            if solution[guessIndex] == element.letter.lowercased() {
                newBoard.board[line][guessIndex].state = .rightLetterRightPlace
                solution[guessIndex] = ""
                continue
            }
            
            for (solutionIndex, solutionLetter) in solution.enumerated()
            where solutionLetter == element.letter.lowercased() && element.state == .unconfirmedGuess {
                newBoard.board[line][guessIndex].state = .rightLetterWrongPlace
                solution[solutionIndex] = ""
                shouldContinue = true
                break
            }
            
            if (shouldContinue) {
                continue
            }
            
            if element.state == .unconfirmedGuess {
                newBoard.board[line][guessIndex].state = .wrongLetterWrongPlace
            }
        }

        if compareCommitToWinWord(gameBoard: newBoard) {
            newBoard.winMessage = "You won!"
            
            return newBoard
            
        } else {
            if gameBoard.currentGuess < 5 {
                newBoard.currentGuess += 1
            }
            
            if gameBoard.currentGuess == 5 {
                newBoard.winMessage = "You lose 😔"
            }
        
            return newBoard
        }
        
    } else {
        return gameBoard
    }
}
