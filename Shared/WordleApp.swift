//
//  WordleApp.swift
//  Shared
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

@main
struct WordleApp: App {
  @StateObject private var gameManager = GameManager(wordService: DefaultWordService())
  
  var body: some Scene {
    WindowGroup {
      GameView()
        .environmentObject(gameManager)
    }
  }
}
