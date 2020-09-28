//
//  Transformer.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import Foundation

struct Transformer: Codable {
   /// Assigned after storing in the server.
   var id: String?
   var team: Team
   var name: String

   var strength: Int
   var intelligence: Int
   var speed: Int
   var endurance: Int
   var rank: Int
   var courage: Int
   var firepower: Int
   var skill: Int

   var overallRating: Int {
      return strength + intelligence + speed + endurance + firepower
   }

   enum Team: String, Codable {
      case autobot = "A"
      case decepticon = "D"
   }

   struct List: Decodable {
      let transformers: [Transformer]
   }
}

/// Helps defining a transformer with a simple string
/// like `"Soundwave, D, 8,9,2,6,7,5,6,10"`
extension Transformer: ExpressibleByStringLiteral {
   init(stringLiteral value: StringLiteralType) {
      // FIXME: needs validation
      let comps = value.components(separatedBy: ",")
      name = comps[0].trimmed
      team = Team(rawValue: comps[1].trimmed)!
      strength = Int(comps[2].trimmed)!
      intelligence = Int(comps[3].trimmed)!
      speed = Int(comps[4].trimmed)!
      endurance = Int(comps[5].trimmed)!
      rank = Int(comps[6].trimmed)!
      courage = Int(comps[7].trimmed)!
      firepower = Int(comps[8].trimmed)!
      skill = Int(comps[9].trimmed)!
   }
}
