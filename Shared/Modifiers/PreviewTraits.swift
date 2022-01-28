//
//  PreviewTraits.swift
//  Wordle
//
//  Created by Robert Moyer on 1/25/22.
//

import SwiftUI

struct PreviewTraits: ViewModifier {

  let previewLayout: PreviewLayout

  func body(content: Content) -> some View {
    Group {
      content
        .preferredColorScheme(.light)
      
      content
        .preferredColorScheme(.dark)
    }
    .previewLayout(previewLayout)
  }
}

extension View {
  func withPreviewTraits(layout: PreviewLayout = .sizeThatFits) -> some View {
    modifier(PreviewTraits(previewLayout: layout))
  }
}
