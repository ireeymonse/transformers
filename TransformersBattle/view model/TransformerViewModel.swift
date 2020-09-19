//
//  TransformerViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import Foundation

class TransformerViewModel {
   var transformer: Transformer

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
