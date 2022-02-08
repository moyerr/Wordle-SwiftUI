//
//  Sequence+.swift
//  Wordle
//
//  Created by Robert Moyer on 2/7/22.
//

import Foundation

extension Sequence {
  func count(
    where predicate: (Element) throws -> Bool
  ) rethrows -> Int {
    try filter(predicate).count
  }
}
