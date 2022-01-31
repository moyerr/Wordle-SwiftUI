//
//  StatsView.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import SwiftUI

struct Stats {
  let gamesPlayed: Int
  let winPercent: Double
  let currentStreak: Int
  let longestStreak: Int

  static var testData: Stats {
    .init(gamesPlayed: 12, winPercent: 0.88, currentStreak: 3, longestStreak: 5)
  }
}

struct StatItemView: View {
  let statText: String
  let statLabel: String

  var body: some View {
    VStack(alignment: .center) {
      VStack {
        Text(statText)
          .font(.title)
      }
      VStack {
        Text(statLabel)
          .font(.caption)
          .lineLimit(2)
          .multilineTextAlignment(.center)
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity)
  }
}

struct StatsView: View {
  @Binding var isShowing: Bool
  @State var stats: Stats

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 24) {
          StatsHeaderView(stats: stats)

          Text("GUESS DISTRIBUTION").bold()

          ZStack {
            Rectangle()
              .fill(Color.random())
              .frame(height: 200)

            Text("Placeholder for chart")
          }

          StatsFooterView()
        }.padding()
      }
        .navigationTitle("STATISTICS")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              isShowing = false
            } label: {
              Image(systemName: "xmark")
            }.tint(.primaryButton)
          }
        }
    }
  }
}

struct StatsView_Previews: PreviewProvider {
  static var previews: some View {
    StatsView(isShowing: .constant(true), stats: .testData)
      .withPreviewTraits(layout: .device)
  }
}

struct StatsHeaderView: View {
  let stats: Stats

  var body: some View {
    HStack(alignment: .top) {
      StatItemView(statText: "\(stats.gamesPlayed)", statLabel: "Played")
      StatItemView(statText: "\(stats.winPercent)", statLabel: "Win %")
      StatItemView(statText: "\(stats.currentStreak)", statLabel: "Current\nStreak")
      StatItemView(statText: "\(stats.longestStreak)", statLabel: "Max\nStreak")
    }
  }
}

struct StatsFooterView: View {
  var body: some View {
    HStack(spacing: 20) {
      VStack {
        Text("NEXT WORDLE")
          .font(.callout.bold())
        Text("06:14:53")
          .font(.system(size: 24).monospacedDigit())
      }.frame(minWidth: 0, maxWidth: .infinity)
      VSeparatorLine()
      VStack {
        Button {
          // TODO: Share
        } label: {
          HStack {
            Text("SHARE").bold()
            Image(systemName: "square.and.arrow.up")
          }.font(.system(size: 16))
        }
        .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8))
        .tint(.white)
        .background(
          RoundedRectangle(cornerRadius: 6)
            .fill(Color.correct)
        )
      }.frame(minWidth: 0, maxWidth: .infinity)
    }
  }
}
