//
//  StatsHeaderView.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

import SwiftUI

struct StatsHeaderView: View {
  let stats: Stats

  var body: some View {
    HStack(alignment: .top) {
      StatItemView(statText: "\(stats.gamesPlayed)", statLabel: "Played")
      StatItemView(statText: "\(format: stats.winPercent, using: .percent)", statLabel: "Win %")
      StatItemView(statText: "\(stats.currentStreak)", statLabel: "Current\nStreak")
      StatItemView(statText: "\(stats.longestStreak)", statLabel: "Max\nStreak")
    }
  }
}
