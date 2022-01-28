//
//  KeyboardKey.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

enum LetterGuessResult: Comparable, Hashable {
  case notInWord
  case wrongPositionInWord
  case correctPositionInWord
}

enum LetterState {
  case unused
  case used(LetterGuessResult)
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
      case .notInWord:
        return .incorrect
      case .wrongPositionInWord:
        return .almostCorrect
      case .correctPositionInWord:
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
