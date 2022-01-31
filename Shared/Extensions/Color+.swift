//
//  Color+.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

extension Color {
  static var primaryBackground: Color { Color(UIColor.systemBackground) }
  static var secondaryBackground: Color { Color(UIColor.systemGray2) }

  static let primaryButton = Color("primaryButton")

  static let emptySquareBorder = Color("emptySquareBorder")
  static let filledSquareBorder = Color("filledSquareBorder")

  static let incorrect = Color("incorrect")
  static let almostCorrect = Color(
    red: 181 / 255,
    green: 159 / 255,
    blue: 59 / 255
  )
  static let correct = Color(
    red: 83 / 255,
    green: 141 / 255,
    blue: 78 / 255
  )

  static func random() -> Color {
    Color(
      red: .random(in: 0 ..< 1),
      green: .random(in: 0 ..< 1),
      blue: .random(in: 0 ..< 1)
    )
  }
}

struct Color_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      Color.incorrect
      Color.almostCorrect
      Color.correct
    }
    .previewLayout(.fixed(width: 100, height: 100))
  }
}
