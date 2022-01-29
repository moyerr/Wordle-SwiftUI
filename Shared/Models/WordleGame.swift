//
//  WordleGame.swift
//  Wordle
//
//  Created by Robert Moyer on 1/26/22.
//

import SwiftUI

final class WordleGame: ObservableObject {
  private static let maxAttempts = 6
  private static let wordLength = 5

  let correctWord: [Letter] = [.c, .r, .a, .c, .k]

  @Published private(set) var lettersUsed = [Letter: LetterResult]()
  @Published private(set) var grid = GameGrid(
    width: WordleGame.wordLength,
    height: WordleGame.maxAttempts
  )

  private var round = 0
  private var character = 0

  func keyboardDidPress(_ key: Key) {
    switch key {
    case .letter(let letter):
      guard grid[round].letters.count < WordleGame.wordLength else { return }

      grid[round, character].letter = letter
      character += 1
    case .enter:
      if grid[round].letters.count == WordleGame.wordLength {
        commitGuess()
      }
    case .delete:
      if !grid[round].letters.isEmpty {
        character -= 1
        grid[round, character].letter = nil
      }
    }
  }

  private func commitGuess() {
    let word = grid[round].letters

    // Easy path - if they got it, game over
    guard word != correctWord else {
      word.forEach { lettersUsed[$0] = .correct }
      (0 ..< Self.wordLength).forEach { letter in
        grid[round, letter].result = .correct
      }

      // TODO: Game over
      return
    }

    for (index, letter) in word.enumerated() {
      guard correctWord.indices.contains(index) else { continue }

      if correctWord.contains(letter) {
        let result: LetterResult = (correctWord[index] == letter) ?
          .correct :
          .present

        grid[round, index].result = result
      } else {
        grid[round, index].result = .absent
      }
    }

    completeRound()
  }

  private func completeRound() {
    round += 1
    character = 0

    updateLettersUsed()

    // TODO: Check for game over
  }

  private func updateLettersUsed() {
    lettersUsed = grid.rows[0 ..< round]
      .reduce(into: [Letter: LetterResult]()) { partialResult, nextRow in
        for square in nextRow.squares {
          guard let letter = square.letter, let result = square.result else { continue }

          if let existingResult = partialResult[letter] {
            if result > existingResult { partialResult[letter] = result }
          } else {
            partialResult[letter] = result
          }
        }
      }
  }
}
