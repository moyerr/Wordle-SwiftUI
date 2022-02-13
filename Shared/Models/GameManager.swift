//
//  GameManager.swift
//  Wordle
//
//  Created by Robert Moyer on 2/13/22.
//

import Combine

final class GameManager: ObservableObject {
  @Stored(filename: "game-history")
  private var history = [GameData]()
  
  @Published var game: WordleGame
  var stats: Stats { history.stats }

  let wordService: WordService

  private var cancellables = Set<AnyCancellable>()

  init(wordService: WordService) {
    self.wordService = wordService
    self.game = WordleGame(wordService: wordService)
  }

  func updateHistory(with data: GameData) {
    history.append(data)
  }

  private func listenForChanges() {
    $game
      .compactMap(\.completedGameData)
      .sink(receiveValue: updateHistory(with:))
      .store(in: &cancellables)
  }
}
