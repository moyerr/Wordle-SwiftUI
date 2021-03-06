//
//  GameGridSquare.swift
//  Wordle
//
//  Created by Robert Moyer on 1/27/22.
//

import SwiftUI

struct GameGridSquare: View {
  let square: GameSquare

  var body: some View {
    ZStack {
      Rectangle()
        .stroke(
          square.letter == nil ? Color.emptySquareBorder : Color.filledSquareBorder,
          lineWidth: square.result == nil ? 3 : 0
        )
      Text(square.letter?.displayValue ?? " ")
        .foregroundColor(
          square.result == nil ? .primary : .white
        )
        .font(.system(size: 300, weight: .bold))
        .minimumScaleFactor(0.01)
        .padding(4)
    }
    .background(backgroundColor)
    .aspectRatio(1, contentMode: .fit)
    .frame(maxWidth: 60)
  }
  
  private var backgroundColor: Color {
    switch square.result {
    case nil:
      return Color.clear
    case .absent:
      return Color.incorrect
    case .present:
      return Color.almostCorrect
    case .correct:
      return Color.correct
    }
  }
}

struct GameGridSquare_Previews: PreviewProvider {
  static var previews: some View {
    GameGridSquare(square: GameSquare(letter: .w, result: .absent))
      .withPreviewTraits(layout: .fixed(width: 150, height: 150))
  }
}
