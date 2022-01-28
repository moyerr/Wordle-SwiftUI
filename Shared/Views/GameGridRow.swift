//
//  GameGridRow.swift
//  Wordle
//
//  Created by Robert Moyer on 1/26/22.
//

import SwiftUI

struct GameGridRow: View {
  let row: GameRow

  var body: some View {
    HStack {
      ForEach(row.squares, id: \.self) { square in
        GameGridSquare(square: square)
      }
    }
  }
}

//struct GameGridRow_Previews: PreviewProvider {
//  static var previews: some View {
//    GameGridRow(
//      row: [
//        GameSquare(letter: .w, result: nil),
//        GameSquare(letter: .h, result: nil),
//        GameSquare(letter: .a, result: nil),
//        GameSquare(letter: nil, result: nil),
//        GameSquare(letter: nil, result: nil),
//      ]
//    ).withPreviewTraits(layout: .fixed(width: 500, height: 100))
//  }
//}
