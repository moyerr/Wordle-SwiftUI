//
//  SeparatorLine.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import SwiftUI

struct HSeparatorLine: View {
    var body: some View {
      Rectangle()
        .fill(Color.emptySquareBorder)
        .frame(height: 2)
    }
}

struct VSeparatorLine: View {
    var body: some View {
      Rectangle()
        .fill(Color.emptySquareBorder)
        .frame(width: 2)
    }
}
