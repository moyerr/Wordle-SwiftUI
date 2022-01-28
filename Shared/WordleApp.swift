//
//  WordleApp.swift
//  Shared
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

@main
struct WordleApp: App {
  let game = WordleGame()

  var body: some Scene {
    WindowGroup {
      GameView(game: game)
    }
  }
}
