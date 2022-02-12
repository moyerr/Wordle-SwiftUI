//
//  WordleApp.swift
//  Shared
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

@main
struct WordleApp: App {
  var body: some Scene {
    WindowGroup {
      if let provider = try? WordProvider() {
        GameView()
          .environmentObject(WordleGame(provider: provider))
      } else {
        Text("ERROR: Could not get word provider")
      }
    }
  }
}
