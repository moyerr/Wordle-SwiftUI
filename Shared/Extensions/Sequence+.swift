//
//  Sequence+.swift
//  Wordle
//
//  Created by Robert Moyer on 2/7/22.
//

import Foundation

extension Sequence {
  func max<Value>(
    by property: KeyPath<Element, Value>
  ) -> Element? where Value: Comparable {
    self.max { $0[keyPath: property] < $1[keyPath: property] }
  }

  func sorted<Value>(
    by property: KeyPath<Element, Value>
  ) -> [Element] where Value: Comparable {
    self.sorted { $0[keyPath: property] < $1[keyPath: property] }
  }

  func count(
    where predicate: (Element) throws -> Bool
  ) rethrows -> Int {
    try filter(predicate).count
  }
}
