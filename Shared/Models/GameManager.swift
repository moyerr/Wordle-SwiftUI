//
//  GameManager.swift
//  Wordle
//
//  Created by Robert Moyer on 2/13/22.
//

import Combine
import Foundation

final class GameManager: ObservableObject {
  @Stored(filename: "game-history")
  private var history = [GameData]()
  
  @Published var game: WordleGame
  @Published var timeRemaining: TimeInterval

  var stats: Stats { history.stats }

  let wordService: WordService

  private var cancellables = Set<AnyCancellable>()
  private var nextGameStart: Date

  init(wordService: WordService) {
    self.wordService = wordService
    self.game = WordleGame(wordService: wordService)
    self.nextGameStart = Calendar.gregorian.startOfTomorrow
    self.timeRemaining = nextGameStart.timeIntervalSinceNow

    listenForChanges()
  }

  func updateHistory(with data: GameData) {
    history.append(data)
  }

  func resetGameIfNecessary(_ timeRemaining: TimeInterval) {
    guard timeRemaining <= 0 else { return }

    nextGameStart = Calendar.gregorian.startOfTomorrow
    game = WordleGame(wordService: wordService)
  }

  private func listenForChanges() {
    $game
      .compactMap(\.completedGameData)
      .sink(receiveValue: updateHistory(with:))
      .store(in: &cancellables)

    $timeRemaining
      .sink(receiveValue: resetGameIfNecessary(_:))
      .store(in: &cancellables)

    Timer.publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .map { [nextGameStart] _ in nextGameStart.timeIntervalSinceNow }
      .assign(to: &$timeRemaining)
  }
}
