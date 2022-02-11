//
//  GuessBarGraphView.swift
//  Wordle
//
//  Created by Robert Moyer on 2/8/22.
//

import SwiftUI

struct GuessBarGraphView: View {
  let guessDistribution: [Int: Int]

  @State private var width: CGFloat = 20
  private let baseWidth: CGFloat = 20

  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      ForEach(guessDistribution.keys.sorted(), id: \.self) { guess in
        HStack {
          Text("\(guess)")
            .frame(width: 12)
          GeometryReader { geo in
            ZStack(alignment: .trailing) {
              if let count = guessDistribution[guess] {
                let fullWidth = geo.size.width - baseWidth

                Rectangle()
                  .fill(Color.green)
                  .frame(width: baseWidth + fullWidth * fractionalWidth(forCount: count))
                Text("\(count)")
                  .bold()
                  .foregroundColor(.black)
                  .padding(.trailing, 5)
              }
            }
          }
        }
      }
    }
  }

  private func fractionalWidth(forCount count: Int) -> CGFloat {
    guard let max = guessDistribution.values.max(), max > 0 else { return 0 }

    return CGFloat(count) / CGFloat(max)
  }
}

struct GuessBarGraphView_Previews: PreviewProvider {
  static let dict = [
    1: 0,
    2: 1,
    3: 4,
    4: 6,
    5: 6,
    6: 2
  ]
  
  static var previews: some View {
    GuessBarGraphView(guessDistribution: dict)
      .withPreviewTraits(layout: .device)
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
