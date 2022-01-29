//
//  Keyboard.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct Keyboard: View {
  @ObservedObject var game: WordleGame

  private let horizontalSpacing: CGFloat = 4

  var body: some View {
    VStack(spacing: 6) {
      ForEach(Keyboard.rows, id: \.self) { row in
        HStack(spacing: horizontalSpacing) {
          ForEach(row) { key in
            keyboardKey(key) {
              game.keyboardDidPress(key)
            }
          }
        }
      }
    }
  }

  @ViewBuilder
  private func keyboardKey(
    _ key: Key,
    onPress: @escaping () -> Void
  ) -> some View {
    if case let .letter(letter) = key {
      KeyboardKey(
        key: key,
        state: game.lettersUsed[letter] == nil ?
          .unused :
          .used(game.lettersUsed[letter]!),
        action: onPress
      )
    } else {
      KeyboardKey(key: key, state: .unused, action: onPress)
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
