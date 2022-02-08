//
//  MockStats.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

extension Stats {
  static var mock: Stats {
    .init(gamesPlayed: 12, winPercent: 0.88, currentStreak: 3, longestStreak: 5)
  }
}
