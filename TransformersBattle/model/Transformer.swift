//
//  Transformer.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import Foundation

struct Transformer {
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

   enum Team: String {
      case autobot = "A"
      case decepticon = "D"
   }
}
