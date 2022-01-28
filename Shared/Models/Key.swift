//
//  Key.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import Foundation

enum Key: Identifiable, Equatable {
  case letter(Letter)
  case enter, delete

  var requiresWideFrame: Bool {
    switch self {
    case .enter, .delete:
      return true
    default:
      return false
    }
  }

  var id: String {
    switch self {
    case .letter(let letter):
      return "letter-\(letter.id)"
    case .enter:
      return "enter"
    case .delete:
      return "delete"
    }
  }

  var displayValue: String {
    switch self {
    case .letter(let letter):
      return letter.displayValue
    case .enter:
      return "ENTER"
    case .delete:
      return "DELETE"
    }
  }

  static var rows: [[Key]] {
    [
      [.letter(.q), .letter(.w), .letter(.e), .letter(.r), .letter(.t), .letter(.y), .letter(.u), .letter(.i), .letter(.o), .letter(.p)],
      [.letter(.a), .letter(.s), .letter(.d), .letter(.f), .letter(.g), .letter(.h), .letter(.j), .letter(.k), .letter(.l)],
      [.enter, .letter(.z), .letter(.x), .letter(.c), .letter(.v), .letter(.b), .letter(.n), .letter(.m), .delete]
    ]
  }
}
