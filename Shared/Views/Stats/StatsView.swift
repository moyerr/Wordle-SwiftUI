//
//  StatsView.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import SwiftUI

struct StatsView: View {
  @Binding var isShowing: Bool
  let stats: Stats

  var body: some View {
    NavigationView {
      ScrollView {
        VStack(spacing: 24) {
          StatsHeaderView(stats: stats)

          Text("GUESS DISTRIBUTION").bold()

          ZStack {
            Rectangle()
              .fill(Color.random())
              .frame(height: 200)

            Text("Placeholder for chart")
          }

          StatsFooterView()
        }.padding()
      }
        .navigationTitle("STATISTICS")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              isShowing = false
            } label: {
              Image(systemName: "xmark")
            }.tint(.primaryButton)
          }
        }
    }
  }
}

struct StatsView_Previews: PreviewProvider {
  static var previews: some View {
    StatsView(isShowing: .constant(true), stats: .mock)
      .withPreviewTraits(layout: .device)
  }
}
