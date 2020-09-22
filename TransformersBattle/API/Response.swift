//
//  Response.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import Foundation

class Response {
   let data: Data?
   let response: URLResponse?
   let error: Error?

   init(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
      self.data = data
      self.response = response
      self.error = error
   }
}

// MARK: - Decoding

extension Response {
   static let decoder: JSONDecoder = {
      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase
      return decoder
   }()

   func decode<R: Decodable>(as _: R.Type? = nil) throws -> R {
      if let error = error { throw error }
      guard let data = data else { throw APIError.noData }
      return try Self.decoder.decode(R.self, from: data)
   }

   /// The UTF8 strning value of `data`.
   var string: String? {
      if let data = data {
         return String(data: data, encoding: .utf8)
      }
      return nil
   }
}
