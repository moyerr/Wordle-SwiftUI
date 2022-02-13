//
//  MockStats.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

extension Stats {
  static var mock: Stats {
    .init(
      gamesPlayed: 12,
      winPercent: 0.88,
      currentStreak: 3,
      longestStreak: 5,
      guessDistribution: [
        1: 0,
        2: 1,
        3: 4,
        4: 6,
        5: 6,
        6: 2
      ]
    )
  }
}
