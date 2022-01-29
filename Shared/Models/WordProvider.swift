//
//  WordProvider.swift
//  Wordle
//
//  Created by Robert Moyer on 1/28/22.
//

import Foundation

actor WordProvider {
  enum Failure: Error {
    case wordFileNotFound
  }

  var words = [String]()

  init() async throws {
    try await retrieveWords()
  }

  func retrieveWords() async throws {
    guard let url = Bundle.main.url(forResource: "words", withExtension: nil) else { throw Failure.wordFileNotFound }

    let (data, _) = try await URLSession.shared.data(from: url)
    words = try JSONDecoder().decode([String].self, from: data)
  }

  func generateWord() -> String {
    words.randomElement() ?? "hello"
  }
}
