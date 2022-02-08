//
//  Stored.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

@propertyWrapper
struct Stored<Value> where Value: Codable {
  private let url: URL
  private let queue: DispatchQueue
  private let box: Box<Value>

  var wrappedValue: Value {
    get {
      queue.sync { box.value }
    }
    nonmutating set {
      queue.async(flags: .barrier) {
        box.value = newValue
        save(newValue)
      }
    }
  }

  init(wrappedValue: Value, filename: String) {
    self.box = Box(wrappedValue)
    self.queue = DispatchQueue(label: "Stored.Queue.\(filename)")
    self.url = FileManager.default
      .urls(for: .documentDirectory, in: .userDomainMask)[0]
      .appendingPathComponent(filename)

    self.performInitialLoad()
  }

  private func performInitialLoad() {
    queue.async(flags: .barrier) {
      if let savedValue = try? load() {
        box.value = savedValue
      } else {
        save(box.value)
      }
    }
  }

  private func load() throws -> Value {
    let value = try Value.read(from: url)
    print("[Stored] Loaded value from \(url.absoluteString)")
    return value
  }

  private func save(_ newValue: Value) {
    do {
      try newValue.write(to: url)
      print("[Stored] Saved value at \(url.absoluteString)")
    } catch {
      print("[Stored] Failed to save value: \(error)")
    }
  }
}

private final class Box<Value> {
  var value: Value
  init(_ value: Value) {
    self.value = value
  }
}
