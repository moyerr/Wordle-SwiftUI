//
//  StatsFooterView.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

import SwiftUI

struct StatsFooterView: View {
  @EnvironmentObject var gameManager: GameManager

  var body: some View {
    HStack(spacing: 20) {
      VStack {
        Text("NEXT WORDLE")
          .font(.callout.bold())
        Text("\(format: gameManager.timeRemaining)")
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
