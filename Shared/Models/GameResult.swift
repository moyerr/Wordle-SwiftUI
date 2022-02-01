//
//  GameResult.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

enum GameResult: Codable {
  case won(guesses: Int)
  case lost
}
