//
//  MockWordService.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

struct MockWordService: WordService {
  func generateWord() -> [Letter] {
    [.h, .e, .l, .l, .o]
  }

  func isWordValid(_ word: [Letter]) -> Bool { true }
}

extension WordService where Self == MockWordService {
  static var mock: MockWordService { MockWordService() }
}
