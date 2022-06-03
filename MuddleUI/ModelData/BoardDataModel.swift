//
//  BoardDataModel.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/20/22.
//

import Foundation
import SwiftUI

///  Main DataModel for Muddle to function properly.
///
///Contained is:
/// - The horribly named LetterThing struct which holds a String
///   and an Enum State. It is data type designed to represent
///   each individual cell on the board.
/// - The solution word, which is an array of Strings because
///   leaving it as a normal String makes it horrible to use later.
/// - A win message. This is just a String that is initialized as
///   empty and will be manipulated based on win/lose state.
///   I'm going to change this later most likely.
/// - An Index for holding which guess we are currently on.
///   The default is 0 not 1.
/// - The board itself. This is an Array of LetterThing Arrays.
///   When it's created it will always have 6 rows and 5 columns
///   to follow the traditional Wordle format.
struct GameBoard {
    struct LetterThing: Codable, Hashable {
        var letter: String = ""
        var state = LetterState.unknown
    }
    
    var solution: [String] = parseSolution(word: "apple")
    var winMessage: String = ""
    var currentGuess: Int = 0
    

    var board: [[LetterThing]] = {
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
    
    
    
    ///  Returns a Tuple that holds the next open position index in the board. If the row is full then a
    ///  (-1,-1) Tuple will be returned. This will need to be handled outside of the function.

    ///  Iterates through the current guess on the board until a letter with an unknown state is found.
    ///  If one can't be found then a default return statement that is intentionally out of bounds will be
    ///  returned.
    func nextOpenIndex() -> (Int, Int) {
        var letterIndex = 0
        
        for letter in self.board[currentGuess] {
            if letter.state == LetterState.unknown {
                return (currentGuess, letterIndex)
            }
            
            if (letterIndex < 4) {
                letterIndex += 1
            }
        }
        
        return (-1,-1)
    }
    
   
    
    ///  Returns a Tuple that holds the index for last entered in character in a guess. If the row is
    ///  empty then a (currentGuess, 0) Tuple will be returned.

    ///  Iterates through the current guess on the board from the last index until a letter with an
    ///  unconfirmedGuess is found. If one can't be found then a default return statement that is
    ///  intentionally the first index of the current guess is returned.
    func lastEnteredIndex() -> (Int, Int) {
    
        for i in (0..<5).reversed() {
            if self.board[currentGuess][i].state == LetterState.unconfirmedGuess {
                return (currentGuess, i)
            }
        }
        return (currentGuess, 0)
    }
}



/// Returns an Array of Strings. 
///
/// Receives a String as a parameter. This String is interated through per character. The Character is then cast as a String
/// and appended to an Array of Strings. This is to allow easier indexing through the solution in other parts
/// of the program.
func parseSolution(word: String) -> [String] {
    var wordArray: [String] = []
    
    for character in word {
        wordArray.append(String(character))
    }
    
    return wordArray
}



/// Defines potential states for the LetterThing struct
///
/// States include:
/// - unknown -> untouched cell, basically
/// - unconfirmedGuess -> when a cell has been modified, but hasn't been submitted
/// - wrongLetterWrongPlace -> reads like a sentence, but when the letter isn't in the solution at all
/// - rightLetterWrongPlace -> again, reads like a sentence, but when the letter is in the solution, but not the right spot
/// - rightLetterRightPlace -> I'm not going to explain this one.
enum LetterState: Codable {
    case unknown
    case unconfirmedGuess
    case wrongLetterWrongPlace
    case rightLetterWrongPlace
    case rightLetterRightPlace
}

/// Links a color to each potential state case
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
