//
//  StringInterpolation+.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

import Foundation

private let numberFormatter = NumberFormatter()
private let hourMinuteSecondFormatter: DateComponentsFormatter = {
  let formatter = DateComponentsFormatter()
  formatter.allowedUnits = [.hour, .minute, .second]
  formatter.zeroFormattingBehavior = .pad
  return formatter
}()

extension StringInterpolationProtocol where StringLiteralType == String {
  mutating func appendInterpolation(format value: Double, using style: NumberFormatter.Style) {
    if style != numberFormatter.numberStyle {
      // Only mutate if necessary
      numberFormatter.numberStyle = style
    }

    if let result = numberFormatter.string(from: value as NSNumber) {
      appendLiteral(result)
    }
  }

  mutating func appendInterpolation(
    format timeInterval: TimeInterval,
    using formatter: @autoclosure () -> DateComponentsFormatter = hourMinuteSecondFormatter
  ) {
    if let result = formatter().string(from: timeInterval) {
      appendLiteral(result)
    }
  }
}
