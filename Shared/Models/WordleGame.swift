//
//  WordleGame.swift
//  Wordle
//
//  Created by Robert Moyer on 1/26/22.
//

import SwiftUI

enum GameResult: Codable {
  case won(guesses: Int)
  case lost
}

struct GameData: Codable {
  let result: GameResult
  let grid: [String]
  let timestamp: Date
}

final class GameStatsManager {
  @Stored(filename: "game-history")
  private var history = [GameData]()

  func updateHistory(with data: GameData) {
    history.append(data)
  }
}

final class WordleGame: ObservableObject {
  private static let maxAttempts = 6
  private static let wordLength = 5

  private let statManager = GameStatsManager()
  private let wordGenerator: WordGenerator
  private var correctWord: [Letter]

  private var attempt = 0
  private var character = 0

  @Published private(set) var lettersUsed = [Letter: LetterResult]()
  @Published private(set) var grid = GameGrid(
    width: WordleGame.wordLength,
    height: WordleGame.maxAttempts
  )

  init(generator: WordGenerator) {
    self.wordGenerator = generator
    self.correctWord = generator.generateWord()
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

    // Easy path - if they got it, game over
    guard word != correctWord else {
      word.forEach { lettersUsed[$0] = .correct }

      (0 ..< WordleGame.wordLength).forEach { letter in
        grid[attempt, letter].result = .correct
      }

      endGame()
      return
    }

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
    updateLettersUsed()

    attempt += 1
    character = 0

    if attempt >= WordleGame.maxAttempts {
      endGame()
    }
  }

  private func endGame() {
    let gameResult: GameResult = grid[attempt].letters == correctWord ?
      .won(guesses: attempt) :
      .lost

    let gameData = GameData(
      result: gameResult,
      grid: grid.rawStrings,
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
