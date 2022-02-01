//
//  GameData.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation
import SwiftUI

struct GameData: Codable {
  let correctWord: String
  let guesses: [String]
  let timestamp: Date

  var result: GameResult {
    if let finalGuess = guesses.last, finalGuess == correctWord {
      return .won(guesses: guesses.count)
    } else {
      return .lost
    }
  }
}
