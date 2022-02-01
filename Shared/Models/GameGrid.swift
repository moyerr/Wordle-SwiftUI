//
//  GameGrid.swift
//  Wordle
//
//  Created by Robert Moyer on 1/28/22.
//

import Foundation

struct GameGrid {
  var rows: [GameRow]

  init(width: Int, height: Int) {
    rows = (0 ..< height).map {
      GameRow(
        row: $0,
        squares: (0 ..< width).map(GameSquare.empty)
      )
    }
  }

  subscript(row: Int, item: Int) -> GameSquare {
    get { rows[row].squares[item] }
    set { rows[row].squares[item] = newValue }
  }

  subscript(row: Int) -> GameRow {
    get { rows[row] }
    set { rows[row] = newValue }
  }
}

struct GameRow: Hashable {
  let row: Int
  var squares: [GameSquare]

  var letters: [Letter] {
    squares.compactMap(\.letter)
  }
}

struct GameSquare: Hashable {
  let position: Int
  var letter: Letter?
  var result: LetterResult?

  init(
    position: Int = 0,
    letter: Letter?,
    result: LetterResult?
  ) {
    self.position = position
    self.letter = letter
    self.result = result
  }

  static func empty(at position: Int) -> GameSquare {
    .init(position: position, letter: nil, result: nil)
  }
}
