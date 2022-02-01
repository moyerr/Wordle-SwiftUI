//
//  LetterResult.swift
//  Wordle
//
//  Created by Robert Moyer on 1/29/22.
//

import Foundation

enum LetterResult: String, Comparable, Hashable, Codable {
  case absent
  case present
  case correct

  static func < (lhs: LetterResult, rhs: LetterResult) -> Bool {
    switch (lhs, rhs) {
    case (.absent, .present):
      return true
    case (.absent, .correct):
      return true
    case (.present, .correct):
      return true
    default:
      return false
    }
  }
}
