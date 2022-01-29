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
    let wordString = words.randomElement() ?? "hello"
    return wordString.compactMap { Letter(rawValue: String($0)) }
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

