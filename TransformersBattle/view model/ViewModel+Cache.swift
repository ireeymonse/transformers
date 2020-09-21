//
//  ViewModel+Cache.swift
//  TransformersBattle
//
//  Created by Iree García on 20/09/20.
//

import Foundation

extension TransformerViewModel {
   func save(_ completion: @escaping (Error?) -> Void) {
      guard isValid else {
         return completion(APIError.noData)
      }
      let updated = Transformer(
         id: nil, // TODO: edit with id
         team: team,
         name: name,
         strength: Int(self[.strength]),
         intelligence: Int(self[.intelligence]),
         speed: Int(self[.speed]),
         endurance: Int(self[.endurance]),
         rank: Int(self[.rank]),
         courage: Int(self[.courage]),
         firepower: Int(self[.firepower]),
         skill: Int(self[.skill])
      )
      DataCoordinator.save(updated, completion: completion)
   }
}
