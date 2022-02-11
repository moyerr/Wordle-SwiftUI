//
//  StringInterpolation+.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

import Foundation

extension String.StringInterpolation {
  mutating func appendInterpolation(format value: Double, using style: NumberFormatter.Style) {
      let formatter = NumberFormatter()
      formatter.numberStyle = style

      if let result = formatter.string(from: value as NSNumber) {
          appendLiteral(result)
      }
  }
}
