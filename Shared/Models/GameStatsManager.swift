//
//  GameStatsManager.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

final class GameStatsManager {
  @Stored(filename: "game-history")
  private var history = [GameData]()

  func updateHistory(with data: GameData) {
    history.append(data)
  }


  private func computeStats() -> Stats {
    let gamesPlayed = history.count
    let gamesWon = history.count { $0.result == .won
    }

    let calendar = Calendar(identifier: .gregorian)
    
    return Stats(
      gamesPlayed: gamesPlayed,
      winPercent: Double(gamesWon) / Double(gamesPlayed),
      currentStreak: 0,
      longestStreak: 0
    )
  }
}
