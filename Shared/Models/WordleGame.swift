//
//  WordleGame.swift
//  Wordle
//
//  Created by Robert Moyer on 1/26/22.
//

import Foundation

struct WordleGame {
  private static let maxAttempts = 6
  private static let wordLength = 5

  private let wordService: WordService

  private var correctWord: [Letter]
  private var attempt = 0
  private var character = 0

  private(set) var completedGameData: GameData? = nil
  private(set) var lettersUsed = [Letter: LetterResult]()
  private(set) var grid = GameGrid(
    width: WordleGame.wordLength,
    height: WordleGame.maxAttempts
  )

  init(wordService: WordService) {
    self.wordService = wordService
    self.correctWord = wordService.generateWord()
  }

  mutating func keyboardDidPress(_ key: Key) {
    guard completedGameData == nil else { return }
    
    switch key {
    case .letter(let letter):
      guard grid[attempt].letters.count < WordleGame.wordLength else { return }

      grid[attempt, character].letter = letter
      character += 1
    case .enter:
      guard
        grid[attempt].letters.count == WordleGame.wordLength,
        wordService.isWordValid(grid[attempt].letters)
      else { return }

        commitGuess()
    case .delete:
      if !grid[attempt].letters.isEmpty {
        character -= 1
        grid[attempt, character].letter = nil
      }
    }
  }

  private mutating func commitGuess() {
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

  private mutating func completeRound() {
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

  private mutating func endGame() {
    let rawGuesses = grid.rows[0 ..< attempt].map {
      $0.squares.compactMap(\.letter).string
    }

    completedGameData = GameData(
      correctWord: correctWord.string,
      guesses: rawGuesses,
      timestamp: Date()
    )
  }

  private mutating func updateLettersUsed() {
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

extension Array where Element == Letter {
  var string: String {
    map(\.rawValue).joined()
  }
}
