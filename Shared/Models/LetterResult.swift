//
//  LetterResult.swift
//  Wordle
//
//  Created by Robert Moyer on 1/29/22.
//

import Foundation

enum LetterResult: Comparable, Hashable {
  case absent
  case present
  case correct
}
