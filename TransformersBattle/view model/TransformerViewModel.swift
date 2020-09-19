//
//  TransformerViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import Foundation

class TransformerViewModel {
   var transformer: Transformer

   /// Instance for a new transformer, initialized with default values
   init() {
      transformer = Transformer(
         team: .autobot, name: "",
         strength: 0, intelligence: 0, speed: 0, endurance: 0,
         rank: 0, courage: 0, firepower: 0, skill: 0
      )
   }

   /// Instance for an existing transformer
   init(_ transformer: Transformer) {
      self.transformer = transformer
   }

   var teamName: String {
      switch transformer.team {
      case .autobot: return "Autobot"
      case .decepticon: return "Decepticon"
      }
   }
}
