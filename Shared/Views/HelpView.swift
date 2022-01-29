//
//  HelpView.swift
//  Wordle
//
//  Created by Robert Moyer on 1/29/22.
//

import SwiftUI

struct HelpView: View {
  @Binding var isShowing: Bool

  var body: some View {
    NavigationView {
      ScrollView {
        content
      }
        .navigationTitle("HOW TO PLAY")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              isShowing = false
            } label: {
              Image(systemName: "xmark")
            }.tint(.primaryButton)
          }
        }
    }
  }

  @ViewBuilder
  private var content: some View {
    VStack(alignment: .leading) {
      Text("""
      Guess the **WORDLE** in 6 tries.

      Each guess must be a valid 5 letter word. Hit the enter button to submit.

      After each guess, the color of the tiles will change to show how close your guess was to the word.
      """
      )
        .multilineTextAlignment(.leading)

      Rectangle()
        .fill(Color.emptySquareBorder)
        .frame(height: 2)

      examples

      Rectangle()
        .fill(Color.emptySquareBorder)
        .frame(height: 2)

      Text("A new WORDLE will be available each day!")
        .bold()
    }
    .padding()
  }

  @ViewBuilder
  private var examples: some View {
    VStack(alignment: .leading) {
      Text("Examples").bold()

      GameGridRow(
        row: GameRow(row: 0, squares: [
          GameSquare(letter: .w, result: .correct),
          GameSquare(letter: .e, result: nil),
          GameSquare(letter: .a, result: nil),
          GameSquare(letter: .r, result: nil),
          GameSquare(letter: .y, result: nil),
        ])
      ).padding()

      Text("The letter **W** is in the word and in the correct spot.")

      GameGridRow(
        row: GameRow(row: 0, squares: [
          GameSquare(letter: .p, result: nil),
          GameSquare(letter: .i, result: .present),
          GameSquare(letter: .l, result: nil),
          GameSquare(letter: .l, result: nil),
          GameSquare(letter: .s, result: nil),
        ])
      ).padding()

      Text("The letter **I** is in the word but in the wrong spot.")

      GameGridRow(
        row: GameRow(row: 0, squares: [
          GameSquare(letter: .v, result: nil),
          GameSquare(letter: .a, result: nil),
          GameSquare(letter: .g, result: nil),
          GameSquare(letter: .u, result: .absent),
          GameSquare(letter: .e, result: nil),
        ])
      ).padding()

      Text("The letter **U** is not in the word in any spot.")
    }
  }
}

struct HelpView_Previews: PreviewProvider {
  static var previews: some View {
    HelpView(isShowing: .constant(true))
      .previewDevice("iPhone 13 mini")
      .withPreviewTraits(layout: .device)
  }
}
