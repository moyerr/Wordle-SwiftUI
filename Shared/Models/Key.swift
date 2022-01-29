//
//  Key.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import Foundation

enum Key: Identifiable, Hashable {
  case letter(Letter)
  case enter, delete

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
}
