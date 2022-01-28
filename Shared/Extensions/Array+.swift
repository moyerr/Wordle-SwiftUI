//
//  Array+.swift
//  Wordle
//
//  Created by Robert Moyer on 1/27/22.
//

import Foundation

extension Array {
  func padding(_ element: Element, toLegnth length: Int) -> [Element] {
    self + Array(repeating: element, count: Swift.max(length - count, 0))
  }
}
