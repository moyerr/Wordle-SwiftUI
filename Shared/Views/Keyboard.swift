//
//  Keyboard.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct Keyboard: View {
  @EnvironmentObject var game: WordleGame

  private let horizontalSpacing: CGFloat = 4

  var body: some View {
    VStack(spacing: 6) {
      ForEach(Keyboard.rows, id: \.self) { row in
        HStack(spacing: horizontalSpacing) {
          ForEach(row) { key in
            let keyView = KeyboardKey(key: key) {
              game.keyboardDidPress(key)
            }

            if case let .letter(letter) = key,
                let result = game.lettersUsed[letter] {
              keyView
                .keyStyle(.revealedLetter(result))
            } else {
              keyView
            }
          }
        }
      }
    }
  }
}

struct Keyboard_Previews: PreviewProvider {
  static var previews: some View {
    Keyboard()
      .environmentObject(WordleGame(wordService: .mock))
      .withPreviewTraits()
  }
}

private extension Keyboard {
  static let rows: [[Key]] = [
    [.letter(.q), .letter(.w), .letter(.e), .letter(.r), .letter(.t), .letter(.y), .letter(.u), .letter(.i), .letter(.o), .letter(.p)],
    [.letter(.a), .letter(.s), .letter(.d), .letter(.f), .letter(.g), .letter(.h), .letter(.j), .letter(.k), .letter(.l)],
    [.enter, .letter(.z), .letter(.x), .letter(.c), .letter(.v), .letter(.b), .letter(.n), .letter(.m), .delete]
  ]
}

private extension Key {
  var unitWidth: CGFloat {
    switch self {
    case .enter, .delete:
      return 1.5
    default:
      return 1
    }
  }
}

private extension Array where Element == Key {
  var widthUnits: CGFloat {
    reduce(into: 0) { partialResult, key in
      partialResult += key.unitWidth
    }
  }
}
