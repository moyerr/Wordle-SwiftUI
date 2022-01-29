//
//  Keyboard.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct Keyboard: View {
  @ObservedObject var game: WordleGame

  private let keyRows = Key.rows
  private let horizontalSpacing: CGFloat = 4

  private func width(_ width: CGFloat, of key: Key, in row: [Key]) -> CGFloat {
    let maxChunks = keyRows.map(\.chunks).max()!

    let scale: CGFloat = key.requiresWideFrame ? 1.5 : 1
    let availableWidth = width - (horizontalSpacing * (CGFloat(row.count) - 1))

    return scale * (availableWidth / CGFloat(maxChunks))
  }

  var body: some View {
    VStack(spacing: 6) {
      ForEach(keyRows.indices, id: \.self) { index in
        HStack(spacing: horizontalSpacing) {
          ForEach(keyRows[index]) { key in
            if case let .letter(letter) = key {
              KeyboardKey(
                key: key,
                state: game.lettersUsed[letter] == nil ? .unused : .used(game.lettersUsed[letter]!)
              ) {
                game.keyboardDidPress(key)
              }
            } else {
              KeyboardKey(key: key, state: .unused) {
                game.keyboardDidPress(key)
              }
            }
          }
        }
      }
    }
  }
}

struct Keyboard_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Keyboard(game: WordleGame())
        .previewInterfaceOrientation(.landscapeLeft)
      Keyboard(game: WordleGame())
        .preferredColorScheme(.dark)
        .previewInterfaceOrientation(.landscapeLeft)
    }
  }
}

extension Array where Element == Key {
  var chunks: Int {
    reduce(into: 0) { partialResult, key in
      partialResult += key.requiresWideFrame ? 2 : 1
    }
  }
}
