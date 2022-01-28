//
//  GameGridView.swift
//  Wordle
//
//  Created by Robert Moyer on 1/27/22.
//

import SwiftUI

struct GameGridView: View {
  let grid: GameGrid

  var body: some View {
    VStack {
      ForEach(grid.rows, id: \.self) { row in
        GameGridRow(row: row)
      }
    }
  }
}
