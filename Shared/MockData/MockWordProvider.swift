//
//  MockWordGenerator.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

struct MockWordProvider: WordProviding {
  func generateWord() -> [Letter] {
    [.h, .e, .l, .l, .o]
  }
}

extension WordProviding where Self == MockWordProvider {
  static var mock: MockWordProvider { MockWordProvider() }
}
