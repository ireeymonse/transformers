//
//  API+Requests.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import Foundation

/// Enables dependency injection for testing purposes
protocol TransformersAPIProtocol {
   func ensureAllSpark()
   func getTransformers(_ completion: @escaping (Response) -> Void)
   /// If the transformer doesn't have an id, a new instance will be created on the server
   func saveTransformer(_ transformer: Transformer, completion: @escaping (Response) -> Void)
   func removeTransformer(id: String, completion: @escaping (Response) -> Void)
}

extension URL {
   static let allSpark = URL(string: "https://transformers-api.firebaseapp.com/allspark")!
   static let transformers = URL(string: "https://transformers-api.firebaseapp.com/transformers")!
}

extension API: TransformersAPIProtocol {
   /// Queue requests if authToken is being fetched.
   private static var authTaskQueue: [() -> Void]?

   func ensureAllSpark() {
      if API.authToken != nil || API.authTaskQueue != nil {
         print("AllSpark available")
         return
      }
      print("Fetching AllSpark")
      // TODO: thread safety
      API.authTaskQueue = []
      request(.allSpark, method: .get) { response in
         response.string.map { allSpark in
            API.authToken = allSpark
            // execute tasks now that allspark is available
            API.authTaskQueue?.forEach { task in task() }
         }
         API.authTaskQueue = nil
      }
   }

   // FIXME: this looks a lot like an operation queue
   private func waitForAllSpark(task: @escaping () -> Void) {
      if API.authTaskQueue != nil {
         API.authTaskQueue?.append(task)
      } else {
         task()
      }
   }

   func getTransformers(_ completion: @escaping (Response) -> Void) {
      waitForAllSpark {
         self.request(.transformers, method: .get, completion)
      }
   }

   func saveTransformer(_ transformer: Transformer, completion: @escaping (Response) -> Void) {
      waitForAllSpark {
         do {
            self.request(.transformers,
                         method: transformer.id == nil ? .post : .put,
                         body: try transformer.responseBody(),
                         completion)
         } catch {
            completion(.init(nil, nil, error))
         }
      }
   }

   func removeTransformer(id: String, completion: @escaping (Response) -> Void) {
      waitForAllSpark {
         self.request(URL.transformers.appendingPathComponent(id),
                      method: .delete, completion)
      }
   }
}

private extension Encodable {
   /// Encodes this object as
   func responseBody() throws -> Data {
      let encoder = JSONEncoder()
      encoder.keyEncodingStrategy = .convertToSnakeCase
      return try encoder.encode(self)
   }
}
