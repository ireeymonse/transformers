//
//  SpecViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import Foundation

class SpecViewModel {
   let label: String
   var value: Float {
      didSet { value = floor(value) }
   }

   init(spec: TransformerSpec, value: Int) {
      label = spec.rawValue.capitalized
      self.value = Float(value)
   }

   var isValid: Bool {
      1 ... 10 ~= value
   }
}

enum TransformerSpec: String, CaseIterable {
   case strength
   case intelligence
   case speed
   case endurance
   case rank
   case courage
   case firepower
   case skill
}
