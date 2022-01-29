//
//  WordProvider.swift
//  Wordle
//
//  Created by Robert Moyer on 1/28/22.
//

import Foundation

protocol WordGenerator {
  func generateWord() -> [Letter]
}

final class WordProvider: WordGenerator {
  enum Failure: Error {
    case wordFileNotFound
  }

  var words = [String]()

  init() throws {
    guard let url = Bundle.main.url(forResource: "words", withExtension: nil) else { throw Failure.wordFileNotFound }

    let data = try Data(contentsOf: url)
    words = try JSONDecoder().decode([String].self, from: data)
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

// MARK: Test Generator

struct TestWordGenerator: WordGenerator {
  func generateWord() -> [Letter] {
    [.h, .e, .l, .l, .o]
  }
}

extension WordGenerator where Self == TestWordGenerator {
  static var test: TestWordGenerator { TestWordGenerator() }
}

private extension String {
  var letters: [Letter] {
    compactMap { Letter(rawValue: String($0)) }
  }
}
