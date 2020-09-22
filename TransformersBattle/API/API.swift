//
//  API.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import Foundation

enum APIError: Error {
   case badURL
   case noData
   case cannotDecode(DecodingError)
   case unknown(Error)
}

enum HTTPMethod: String {
   case get, post, put, delete
}

class API {
   @SecureStorage(key: "api.auth.token") static var authToken: String?

   let session: URLSession = {
      let config = URLSessionConfiguration.default
      config.allowsCellularAccess = true
      if #available(iOS 11.0, *) {
         config.waitsForConnectivity = true
      }
      return URLSession(configuration: config)
   }()

   func request(_ url: @autoclosure () throws -> URL,
                method: HTTPMethod,
                mimeType: String = "application/json",
                body: Data? = nil,
                _ completion: @escaping (Response) -> Void) {
      var request: URLRequest
      do {
         request = URLRequest(url: try url())
      } catch {
         return completion(.init(nil, nil, APIError.badURL))
      }

      request.httpMethod = method.rawValue
      request.addValue(mimeType, forHTTPHeaderField: "Content-Type")
      Self.authToken.map {
         request.addValue("Bearer \($0)", forHTTPHeaderField: "Authorization")
      }
      request.httpBody = body

      session.dataTask(with: request) { data, response, error in
         DispatchQueue.main.async {
            completion(.init(data, response, error))
         }
      }.resume()
   }
}
