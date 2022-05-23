//
//  GameState.swift
//  MuddleUI
//
//  Created by Christian Viazzo on 5/20/22.
//

import Foundation

struct GameState: Codable {
    let guesses: [String]
    let targetWord: String
    let stats: PlayerStats
}

struct PlayerStats: Codable {
    let wins: Int
    let losses: Int
    let strak: Int
}
