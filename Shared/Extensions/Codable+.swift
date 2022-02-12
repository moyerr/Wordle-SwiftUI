//
//  FileManager+.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

extension Encodable {
  func write(
    to url: URL,
    using encoder: DataEncoder = JSONEncoder(),
    options: Data.WritingOptions = [.atomic]
  ) throws {
    let data = try encoder.encode(self)
    try data.write(to: url, options: options)
  }
}

extension Decodable {
  static func read(from url: URL, using decoder: DataDecoder = JSONDecoder()) throws -> Self {
    let data = try Data(contentsOf: url)
    return try decoder.decode(Self.self, from: data)
  }
}

protocol DataDecoder {
  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

protocol DataEncoder {
  func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONDecoder: DataDecoder {}
extension PropertyListDecoder: DataDecoder {}

extension JSONEncoder: DataEncoder {}
extension PropertyListEncoder: DataEncoder {}
