//
//  GameView.swift
//  Shared
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct GameView: View {
  @ObservedObject var game: WordleGame

  @State private var showingHelpPage = false
  @State private var showingStatsPage = false

  var body: some View {
    VStack {
      HeaderView(
        showHelp: $showingHelpPage,
        showStats: $showingStatsPage,
        showSettings: .constant(false)
      )

      HSeparatorLine()

      Spacer()
      GameGridView(grid: game.grid)
      Spacer()
      
      Keyboard(game: game)
    }
    .sheet(isPresented: $showingHelpPage) {
      HelpView(isShowing: $showingHelpPage)
    }
    .sheet(isPresented: $showingStatsPage) {
      StatsView(
        isShowing: $showingStatsPage,
        stats: game.statManager.stats,
        guessDistribution: game.statManager.guessDistribution
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(game: WordleGame(provider: .mock))
      .previewDevice("iPad mini (6th generation)")
      .previewInterfaceOrientation(.portraitUpsideDown)
  }
}
