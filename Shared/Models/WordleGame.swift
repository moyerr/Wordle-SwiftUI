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

  private let statManager = GameStatsManager()
  private let wordProvider: WordProviding
  private var correctWord: [Letter]

  private var attempt = 0
  private var character = 0

  private var guesses: [String] {
    grid.rows[0 ..< attempt].map {
      $0.squares.compactMap(\.letter).string
    }
  }

  @Published private(set) var lettersUsed = [Letter: LetterResult]()
  @Published private(set) var grid = GameGrid(
    width: WordleGame.wordLength,
    height: WordleGame.maxAttempts
  )

  init(provider: WordProviding) {
    self.wordProvider = provider
    self.correctWord = provider.generateWord()
  }

  func keyboardDidPress(_ key: Key) {
    switch key {
    case .letter(let letter):
      guard grid[attempt].letters.count < WordleGame.wordLength else { return }

      grid[attempt, character].letter = letter
      character += 1
    case .enter:
      if grid[attempt].letters.count == WordleGame.wordLength {
        commitGuess()
      }
    case .delete:
      if !grid[attempt].letters.isEmpty {
        character -= 1
        grid[attempt, character].letter = nil
      }
    }
  }

  private func commitGuess() {
    let word = grid[attempt].letters

    for (index, letter) in word.enumerated() {
      guard correctWord.indices.contains(index) else { continue }

      if correctWord[index] == letter {
        grid[attempt, index].result = .correct
      } else if correctWord.contains(letter) {
        grid[attempt, index].result = .present
      } else {
        grid[attempt, index].result = .absent
      }
    }

    completeRound()
  }

  private func completeRound() {
    let word = grid[attempt].letters

    updateLettersUsed()

    attempt += 1
    character = 0

    if word == correctWord {
      endGame()
    } else if attempt >= WordleGame.maxAttempts {
      endGame()
    }
  }

  private func endGame() {
    let gameData = GameData(
      correctWord: correctWord.string,
      guesses: guesses,
      lettersUsed: lettersUsed,
      timestamp: Date()
    )

    statManager.updateHistory(with: gameData)
  }

  private func updateLettersUsed() {
    let thisRow = grid[attempt]

    for square in thisRow.squares {
      guard let letter = square.letter, let result = square.result else { continue }

      if let existingResult = lettersUsed[letter] {
        if result > existingResult { lettersUsed[letter] = result }
      } else {
        lettersUsed[letter] = result
      }
    }
  }
}

private extension Array where Element == Letter {
  var string: String {
    map(\.rawValue).joined()
  }
}
