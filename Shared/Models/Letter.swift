//
//  Letter.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import Foundation

enum Letter: String, CaseIterable, Identifiable, Hashable, Codable {
  case a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v, w, x, y, z
  
  var id: String { rawValue }
  var displayValue: String { rawValue.capitalized }
}
