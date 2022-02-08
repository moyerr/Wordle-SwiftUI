//
//  GameStatsManager.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Algorithms
import Foundation

final class GameStatsManager {
  @Stored(filename: "game-history")
  private var history = [GameData]()

  var stats: Stats {
    history.stats
  }

  func updateHistory(with data: GameData) {
    history.append(data)
  }
}

extension Array where Element == GameData {
  var stats: Stats {
    let gamesPlayed = count

    let sortedGames = sorted(by: \.timestamp)
    let wins = sortedGames.filter { $0.result == .won }

    let calendar = Calendar(identifier: .gregorian)

    let winSteaks = wins.chunked { current, next in
      calendar.isDate(next.timestamp, inDayAfter: current.timestamp)
    }

    let longestStreak = winSteaks.max(by: \.count)?.count ?? 0
    let currentStreak = (sortedGames.last?.result ?? .lost) == .lost ? 0 : winSteaks.last?.count ?? 0

    return Stats(
      gamesPlayed: gamesPlayed,
      winPercent: Double(wins.count) / Double(gamesPlayed),
      currentStreak: currentStreak,
      longestStreak: longestStreak
    )
  }
}
