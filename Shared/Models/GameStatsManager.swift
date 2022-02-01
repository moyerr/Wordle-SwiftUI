//
//  GameStatsManager.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

final class GameStatsManager {
  @Stored(filename: "game-history")
  private var history = [GameData]()

  func updateHistory(with data: GameData) {
    history.append(data)
  }
}
