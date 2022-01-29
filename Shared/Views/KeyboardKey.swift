//
//  KeyboardKey.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct KeyboardKey: View {
  @Environment(\.keyStyle) var style

  let key: Key
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      style.makeBody(
        configuration: KeyStyleConfiguration(
          label: KeyStyleConfiguration.Label(
            content: Text(key.displayValue)
              .lineLimit(1)
              .font(.system(size: 14, weight: .black))
              .padding()
          )
        )
      )
    }
  }
}

struct KeyboardKey_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      KeyboardKey(key: .letter(.a), action: {})
        .keyStyle(.revealedLetter(.absent))

      KeyboardKey(key: .letter(.b), action: {})
        .keyStyle(.revealedLetter(.present))

      KeyboardKey(key: .letter(.c), action: {})
        .keyStyle(.revealedLetter(.correct))

      KeyboardKey(key: .letter(.d), action: {})
    }.withPreviewTraits(
      layout: .fixed(width: 80, height: 80)
    )
  }
}
