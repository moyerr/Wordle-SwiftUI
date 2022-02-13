//
//  GameView.swift
//  Shared
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct GameView: View {
  @EnvironmentObject var gameManager: GameManager

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
      GameGridView(grid: gameManager.game.grid)
      Spacer()
      
      Keyboard(game: $gameManager.game)
    }
    .sheet(isPresented: $showingHelpPage) {
      HelpView(isShowing: $showingHelpPage)
    }
    .sheet(isPresented: $showingStatsPage) {
      StatsView(
        isShowing: $showingStatsPage,
        stats: gameManager.stats
      )
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GameView()
      .environmentObject(GameManager(wordService: .mock))
      .previewDevice("iPad mini (6th generation)")
      .previewInterfaceOrientation(.portraitUpsideDown)
  }
}
