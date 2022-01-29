//
//  KeyStyle.swift
//  Wordle
//
//  Created by Robert Moyer on 1/29/22.
//

import SwiftUI

// MARK: - View Support

extension View {
  func keyStyle<S: KeyStyle>(_ style: S) -> some View {
    environment(\.keyStyle, AnyKeyStyle(style: style))
  }
}

// MARK: - Environment Support

struct KeyStyleKey: EnvironmentKey {
  static var defaultValue = AnyKeyStyle(
    style: DefaultKeyStyle()
  )
}

extension EnvironmentValues {
  var keyStyle: AnyKeyStyle {
    get { self[KeyStyleKey.self] }
    set { self[KeyStyleKey.self] = newValue }
  }
}


// MARK: - Style Definition

protocol KeyStyle {
  typealias Configuration = KeyStyleConfiguration
  associatedtype Body: View

  @ViewBuilder func makeBody(configuration: Configuration) -> Body
}

extension KeyStyle where Self == RevealedLetterKeyStyle {
  static func revealedLetter(_ result: LetterResult) -> RevealedLetterKeyStyle {
    RevealedLetterKeyStyle(result: result)
  }
}

// MARK: Configuration

struct KeyStyleConfiguration {
  struct Label: View {
    init<Content: View>(content: Content) {
      body = AnyView(content)
    }

    var body: AnyView
  }

  let label: Label
}

// MARK: Default Key Style

struct DefaultKeyStyle: KeyStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.primary)
      .background(
        RoundedRectangle(cornerRadius: 6)
          .fill(Color.secondaryBackground)
      )
  }
}

// MARK: Letter Key Style

struct RevealedLetterKeyStyle: KeyStyle {
  let result: LetterResult

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .background(
        RoundedRectangle(cornerRadius: 6)
          .fill(keyColor)
      )
  }

  private var keyColor: Color {
    switch result {
    case .absent:
      return .incorrect
    case .present:
      return .almostCorrect
    case .correct:
      return .correct
    }
  }
}

// MARK: Type-Erased Key Style

struct AnyKeyStyle: KeyStyle {
  private var buildBody: (Configuration) -> AnyView

  init<S: KeyStyle>(style: S) {
    buildBody = { configuration in
      AnyView(style.makeBody(configuration: configuration))
    }
  }

  func makeBody(configuration: Configuration) -> some View {
    buildBody(configuration)
  }
}
