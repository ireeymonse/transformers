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
         acc[spec] = SpecViewModel(spec: spec, value: TransformerViewModel.defaultSpecValue)
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

   var isNew: Bool { return id == nil }

   var title: String {
      return "\(isNew ? "Create" : "Edit") Transformer"
   }

   var teamName: String { return team.name }
   var teamSymbol: UIImage? { return team.symbol }
   var teamEditionBackground: UIImage? {
      switch team {
      case .autobot: return UIImage(named: "blueprint")
      case .decepticon: return UIImage(named: "blueprint gray")
      }
   }

   subscript(spec: TransformerSpec) -> Float {
      get {
         return specs[spec]?.value ?? 0
      }
      set {
         specs[spec]?.value = newValue
      }
   }

   var specsList: [SpecViewModel] {
      return TransformerSpec.allCases.compactMap { specs[$0] }
   }

   /// The top specs, hopefully greater than 5
   var relevantSpecsList: [SpecViewModel] {
      let sorted = specsList.sorted { $0.value > $1.value }
      let relevant = sorted.filter { $0.value > 5 }
      // the top 3 above 5pts, or just the rank if really lame
      return relevant.isEmpty ? [specs[.rank]!] : Array(relevant.prefix(3))
   }

   var isValid: Bool {
      return !name.isEmpty && specs.allSatisfy { _, spec in spec.isValid }
   }

   let saveErrorTitle = "Error"
   var saveErrorMessage: String {
      return "\(isNew ? "Your new Transformer" : "'\(name)'") could not be saved. Try again."
   }

   var deleteConfirmationTitle: String {
      return "Delete '\(name)'"
   }
   let deleteConfirmationMessage = "Are you sure?"
   let deleteErrorTitle = "Error"
   var deleteErrorMessage: String {
      return "Could not delete '\(name)'. Try again."
   }
}

extension Transformer.Team {
   var name: String {
      switch self {
      case .autobot: return "Autobot"
      case .decepticon: return "Decepticon"
      }
   }

   var rival: Transformer.Team {
      switch self {
      case .autobot: return .decepticon
      case .decepticon: return .autobot
      }
   }

   var symbol: UIImage? {
      switch self {
      case .autobot: return UIImage(named: "autobot")
      case .decepticon: return UIImage(named: "decepticon")
      }
   }
}
