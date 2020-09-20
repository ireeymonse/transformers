//
//  TransformerViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import Foundation

class TransformerViewModel {
   var team: Transformer.Team
   var name: String {
      didSet { name = name.trimmed }
   }

   var specs: [TransformerSpec: SpecViewModel]

   /// Instance for a new transformer, initialized with default values
   init() {
      team = .autobot
      name = ""
      specs = TransformerSpec.allCases.reduce(into: [:]) { acc, spec in
         acc[spec] = SpecViewModel(spec: spec, value: 0)
      }
   }

   /// Instance for an existing transformer
   init(_ transformer: Transformer) {
      team = transformer.team
      name = transformer.name
      specs = TransformerSpec.allCases.reduce(into: [:]) { acc, spec in
         let value: Int
         switch spec {
         case .strength: value = transformer.strength
         case .intelligence: value = transformer.intelligence
         case .speed: value = transformer.speed
         case .endurance: value = transformer.endurance
         case .rank: value = transformer.rank
         case .courage: value = transformer.courage
         case .firepower: value = transformer.firepower
         case .skill: value = transformer.skill
         }
         acc[spec] = SpecViewModel(spec: spec, value: value)
      }
   }

   var teamName: String {
      switch team {
      case .autobot: return "Autobot"
      case .decepticon: return "Decepticon"
      }
   }

   subscript(spec: TransformerSpec) -> Float {
      get {
         specs[spec]?.value ?? 0
      }
      set {
         specs[spec]?.value = newValue
      }
   }

   var specsList: [SpecViewModel] {
      TransformerSpec.allCases.compactMap { specs[$0] }
   }

   var isValid: Bool {
      !name.isEmpty && specs.allSatisfy { _, spec in spec.isValid }
   }
}
