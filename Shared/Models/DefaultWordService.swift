//
//  WordService.swift
//  Wordle
//
//  Created by Robert Moyer on 1/28/22.
//

import Foundation

protocol WordService {
  func isWordValid(_ word: [Letter]) -> Bool
  func generateWord() -> [Letter]
}

final class DefaultWordService: WordService {
  @Bundled(filename: "words")
  private var words: [String]

  @Bundled(filename: "valid_guesses")
  private var validGuesses: Set<String>

  func isWordValid(_ word: [Letter]) -> Bool {
    validGuesses.contains(word.string)
  }

  func generateWord() -> [Letter] {
    let calendar = Calendar(identifier: .gregorian)

    guard
      let startDate = calendar.date(from: DateComponents(year: 2021, month: 6, day: 19)),
      let elapsedDays = calendar.dateComponents([.day], from: startDate, to: Date()).day,
      words.indices.contains(elapsedDays)
    else {
      return (words.randomElement() ?? "hello").letters
    }

    return words[elapsedDays].letters
  }
}

private extension String {
  var letters: [Letter] {
    compactMap { Letter(rawValue: String($0)) }
  }
}
