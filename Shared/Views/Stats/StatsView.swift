//
//  StatsView.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import SwiftUI

struct StatsView: View {
  @Binding var isShowing: Bool
  let stats: Stats
  let guessDistribution: [Int: Int]

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 24) {
          StatsHeaderView(stats: stats)

          Text("GUESS DISTRIBUTION").bold()

          GuessBarGraphView(guessDistribution: guessDistribution)

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
    StatsView(
      isShowing: .constant(true),
      stats: .mock,
      guessDistribution: [
        1: 0,
        2: 1,
        3: 4,
        4: 6,
        5: 6,
        6: 2
      ]
    )
      .withPreviewTraits(layout: .device)
  }
}
