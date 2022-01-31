//
//  FileManager+.swift
//  Wordle
//
//  Created by Robert Moyer on 1/31/22.
//

import Foundation

extension Encodable {
  func write(to url: URL, using encoder: AnyEncoder = JSONEncoder()) throws {
    let data = try encoder.encode(self)
    try data.write(to: url, options: .atomic)
  }
}

extension Decodable {
  static func read(from url: URL, using decoder: AnyDecoder = JSONDecoder()) throws -> Self {
    let data = try Data(contentsOf: url)
    return try decoder.decode(Self.self, from: data)
  }
}

protocol AnyDecoder {
  func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}

protocol AnyEncoder {
  func encode<T: Encodable>(_ value: T) throws -> Data
}

extension JSONDecoder: AnyDecoder {}
extension PropertyListDecoder: AnyDecoder {}

extension JSONEncoder: AnyEncoder {}
extension PropertyListEncoder: AnyEncoder {}
