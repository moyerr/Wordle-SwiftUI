//
//  StatItemView.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

import SwiftUI

struct StatItemView: View {
  let statText: String
  let statLabel: String

  var body: some View {
    VStack(alignment: .center) {
      VStack {
        Text(statText)
          .font(.title)
      }
      VStack {
        Text(statLabel)
          .font(.caption)
          .lineLimit(2)
          .multilineTextAlignment(.center)
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity)
  }
}
