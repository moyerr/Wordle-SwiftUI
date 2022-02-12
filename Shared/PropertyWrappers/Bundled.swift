//
//  Bundled.swift
//  Wordle
//
//  Created by Robert Moyer on 2/12/22.
//

import Foundation

@propertyWrapper
struct Bundled<Value> where Value: Codable {
  let wrappedValue: Value

  init(filename: String, fileExtension: String? = nil, in bundle: Bundle = .main) {
    guard let url = bundle.url(forResource: filename, withExtension: fileExtension) else {
      fatalError("[Bundled] ERROR: Could not find \(filename) in bundle.")
    }

    do {
      let data = try Data(contentsOf: url)
      let value = try JSONDecoder().decode(Value.self, from: data)

      self.wrappedValue = value
    } catch {
      fatalError("[Bundled] ERROR: \(error)")
    }
  }
}
