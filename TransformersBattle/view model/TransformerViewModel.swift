//
//  TransformerViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import UIKit

class TransformerViewModel {
   static let defaultSpecValue: Float = 5

   let id: String?
   var team: Transformer.Team
   var name: String {
      didSet { name = name.trimmed }
   }

   var specs: [TransformerSpec: SpecViewModel]

   /// Instance for a new transformer, initialized with default values
   init() {
      id = nil
      team = .autobot
      name = ""
      specs = TransformerSpec.allCases.reduce(into: [:]) { acc, spec in
         acc[spec] = SpecViewModel(spec: spec, value: Self.defaultSpecValue)
      }
   }

   /// Instance for an existing transformer
   init(_ transformer: Transformer) {
      id = transformer.id
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
         acc[spec] = SpecViewModel(spec: spec, value: Float(value))
      }
   }

   var title: String {
      "\(id == nil ? "New" : "Edit") Transformer"
   }

   var teamName: String { team.name }
   var teamSymbol: UIImage? {
      switch team {
      case .autobot: return UIImage(named: "autobot")
      case .decepticon: return UIImage(named: "decepticon")
      }
   }

   var teamEditionBackground: UIImage? {
      switch team {
      case .autobot: return UIImage(named: "blueprint")
      case .decepticon: return UIImage(named: "blueprint gray")
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

extension Transformer.Team {
   var name: String {
      switch self {
      case .autobot: return "Autobot"
      case .decepticon: return "Decepticon"
      }
   }

   var rival: Self {
      switch self {
      case .autobot: return .decepticon
      case .decepticon: return .autobot
      }
   }
}
