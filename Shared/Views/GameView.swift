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

  var body: some View {
    VStack {
      HeaderView(
        showHelp: $showingHelpPage,
        showStats: .constant(false),
        showSettings: .constant(false)
      )

      Rectangle()
        .fill(Color.emptySquareBorder)
        .frame(height: 2)

      Spacer()
      GameGridView(grid: game.grid)
      Spacer()
      Keyboard(game: game)
    }
    .sheet(isPresented: $showingHelpPage) {
      HelpView(isShowing: $showingHelpPage)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(game: WordleGame(generator: .test))
      .previewDevice("iPad mini (6th generation)")
      .previewInterfaceOrientation(.portraitUpsideDown)
  }
}
