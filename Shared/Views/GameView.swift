//
//  GameView.swift
//  Shared
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct GameView: View {
  @ObservedObject var game: WordleGame

  var body: some View {
    HStack {
      Spacer()
      VStack {
        Spacer()
        GameGridView(grid: game.grid)
        Spacer()
        Keyboard(game: game)
      }
      Spacer()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(game: WordleGame())
      .previewDevice("iPad mini (6th generation)")
.previewInterfaceOrientation(.landscapeLeft)
  }
}
