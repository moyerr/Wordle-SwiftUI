//
//  GameManager.swift
//  Wordle
//
//  Created by Robert Moyer on 2/13/22.
//

import Combine

final class GameManager: ObservableObject {

  @Published var game: WordleGame

  let statManager = GameStatsManager()
  let wordService: WordService

  private var cancellables = Set<AnyCancellable>()

  init(wordService: WordService) {
    self.wordService = wordService
    self.game = WordleGame(wordService: wordService)
  }

  private func listenForChanges() {
    $game
      .compactMap(\.completedGameData)
      .sink(receiveValue: statManager.updateHistory(with:))
      .store(in: &cancellables)
  }
}
