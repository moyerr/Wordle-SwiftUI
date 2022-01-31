//
//  HeaderView.swift
//  Wordle
//
//  Created by Robert Moyer on 1/29/22.
//

import SwiftUI

struct HeaderView: View {
  @Binding var showHelp: Bool
  @Binding var showStats: Bool
  @Binding var showSettings: Bool

  var body: some View {
    ZStack {
      HStack {
        Button {
          showHelp.toggle()
        } label: {
          Image(systemName: "questionmark.circle")
        }

        Spacer()

        Button {
          showStats.toggle()
        } label: {
          Image(systemName: "chart.bar")
        }

        Button {
          showSettings.toggle()
        } label: {
          Image(systemName: "gearshape.fill")
        }
      }
      .font(.system(size: 24))
      .padding()
      .frame(height: 60)
      .tint(Color.primaryButton)

      Text("WORDLE")
        .font(.largeTitle)
        .bold()
    }
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    HeaderView(
      showHelp: .constant(false),
      showStats: .constant(false),
      showSettings: .constant(false))
      .withPreviewTraits()
  }
}
