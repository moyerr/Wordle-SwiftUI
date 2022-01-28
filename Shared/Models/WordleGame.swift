//
//  WordleGame.swift
//  Wordle
//
//  Created by Robert Moyer on 1/26/22.
//

import SwiftUI

final class WordleGame: ObservableObject {
  struct CompletedRound {
    let guess: [Letter]
    let results: [Letter: LetterGuessResult]
  }

  struct PendingRound {
    var guess = [Letter]()
  }

  private static let maxRounds = 6
  private static let wordLength = 5

  let correctWord: [Letter] = [.c, .r, .a, .c, .k]

  @Published private(set) var cumulativeResults = [Letter: LetterGuessResult]()
  @Published private(set) var completedRounds = [CompletedRound]()
  @Published private(set) var currentRound = PendingRound()
  @Published private(set) var gameGrid: GameGrid

  private var currentRoundNumber = 0
  private var currentCharacter = 0

  init() {
    gameGrid = GameGrid(
      rows: (0 ..< WordleGame.maxRounds).map {
        GameRow(
          row: $0,
          squares: (0 ..< WordleGame.wordLength).map(GameSquare.empty)
        )
      }
    )
  }

  func keyboardDidPress(_ key: Key) {
    switch key {
    case .letter(let letter):
      guard currentRound.guess.count < WordleGame.wordLength else { return }
      currentRound.guess.append(letter)

      gameGrid.rows[currentRoundNumber].squares[currentCharacter].letter = letter
      currentCharacter += 1
    case .enter:
      if currentRound.guess.count == WordleGame.wordLength {
        commitGuess()
      }
    case .delete:
      if !currentRound.guess.isEmpty {
        currentRound.guess.removeLast()
        currentCharacter -= 1
        gameGrid.rows[currentRoundNumber].squares[currentCharacter].letter = nil
      }
    }
  }

  private func commitGuess() {
    let word = currentRound.guess

    // Easy path - if they got it, game over
    guard word != correctWord else {
      word.forEach { cumulativeResults[$0] = .correctPositionInWord }
      // TODO: update winning grid
      return
    }

    var results = [Letter: LetterGuessResult]()

    for (index, letter) in word.enumerated() {
      guard correctWord.indices.contains(index) else { continue }

      if correctWord.contains(letter) {
        let result: LetterGuessResult = (correctWord[index] == letter) ?
          .correctPositionInWord :
          .wrongPositionInWord

        results[letter] = result
        gameGrid.rows[currentRoundNumber].squares[index].result = result
      } else {
        results[letter] = .notInWord
        gameGrid.rows[currentRoundNumber].squares[index].result = .notInWord
      }
    }

    completeRound(CompletedRound(guess: word, results: results))
  }

  private func completeRound(_ completedRound: CompletedRound) {
    completedRounds.append(completedRound)

    updateCumulativeResults()

    currentRound = PendingRound()

    currentRoundNumber += 1
    currentCharacter = 0
  }

  private func updateCumulativeResults() {
    cumulativeResults = completedRounds.reduce(
      into: [Letter: LetterGuessResult]()
    ) { partialResult, nextRound in
      for (letter, result) in nextRound.results {
        if let existingResult = partialResult[letter] {
          if result > existingResult { partialResult[letter] = result }
        } else {
          partialResult[letter] = result
        }
      }
    }
  }
}
