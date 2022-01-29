//
//  KeyboardKey.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

enum LetterResult: Comparable, Hashable {
  case absent
  case present
  case correct
}

enum LetterState {
  case unused
  case used(LetterResult)
}

struct KeyboardKey: View {
  let key: Key
  let state: LetterState
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(key.displayValue)
        .lineLimit(1)
        .foregroundColor(letterColor)
        .font(.system(size: 14, weight: .black))
        .padding()
        .background(
          RoundedRectangle(cornerRadius: 6)
            .fill(keyColor)
        )
    }
  }

  private var keyColor: Color {
    switch state {
    case .unused:
      return .secondaryBackground
    case .used(let result):
      switch result {
      case .absent:
        return .incorrect
      case .present:
        return .almostCorrect
      case .correct:
        return .correct
      }
    }
  }

  private var letterColor: Color {
    guard case .used = state else { return .primary }
    return .white
  }
}

struct KeyboardKey_Previews: PreviewProvider {
  static var previews: some View {
    KeyboardKey(key: .letter(.r), state: .unused, action: {})
      .withPreviewTraits()
  }
}
