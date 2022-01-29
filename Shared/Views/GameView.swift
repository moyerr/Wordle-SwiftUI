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
    VStack {
      Spacer()
      GameGridView(grid: game.grid)
      Spacer()
      Keyboard(game: game)
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    GameView(game: WordleGame())
      .previewInterfaceOrientation(.landscapeRight)
  }
}
