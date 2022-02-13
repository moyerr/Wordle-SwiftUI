//
//  Array+Stats.swift
//  Wordle
//
//  Created by Robert Moyer on 2/13/22.
//

import Algorithms
import Foundation

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

    let winPercent = gamesPlayed > 0 ? Double(wins.count) / Double(gamesPlayed) : 0

    return Stats(
      gamesPlayed: gamesPlayed,
      winPercent: winPercent,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      guessDistribution: guessDistribution
    )
  }

  private var guessDistribution: [Int: Int] {
    map(\.guesses)
      .reduce(
        into: [1: 0, 2: 0, 3: 0, 4: 0, 5: 0, 6: 0]
      ) { partialResult, guesses in
        let currentCount = partialResult[guesses.count] ?? 0
        partialResult[guesses.count] = currentCount + 1
      }
  }
}
