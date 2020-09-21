//
//  BattleViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 20/09/20.
//

import UIKit

enum BattleOutcome {
   case victory(victor: TransformerViewModel,
                eliminated: TransformerViewModel)
   /// Both eliminated
   case tie(TransformerViewModel, TransformerViewModel)
   /// Everyone eliminated
   case mayhem

   init(between a: Transformer, and b: Transformer) {
      // both are Supreme Warriors?
      if let _ = supreme(a, b), let _ = supreme(b, a) {
         print("Mayhem!")
         self = .mayhem
      } else if let outcome = supreme(a, b) ?? supreme(b, a) {
         self = outcome
      } else if let outcome = hero(a, b) ?? hero(b, a) {
         self = outcome
      } else if let outcome = expert(a, b) ?? expert(b, a) {
         self = outcome
      } else if let outcome = overall(a, b) ?? overall(b, a) {
         self = outcome
      } else {
         self = .tie(.init(a), .init(b))
      }
      /** simpler code, but much more compiler intensive
        ```
          self = mayhem(a, b) ??
             supreme(a, b) ?? supreme(b, a) ??
             hero(a, b) ?? hero(b, a) ??
             expert(a, b) ?? expert(b, a) ??
             overall(a, b) ?? overall(b, a) ??
             .tie(.init(a), .init(b))
        ```
       */
   }

   var victor: TransformerViewModel? {
      if case let .victory(victor, _) = self {
         return victor
      }
      return nil
   }

   var eliminated: [TransformerViewModel] {
      switch self {
      case let .victory(_, eliminated): return [eliminated]
      case let .tie(a, b): return [a, b]
      case .mayhem: return []
      }
   }
}

// MARK: - Rules

/// Base function
private func _wins(_ a: Transformer, _ b: Transformer,
                   f: StaticString = #function,
                   condition: () -> Bool) -> BattleOutcome? {
   if condition() {
      print("\(a.name) wins \(f)")
      return .victory(victor: .init(a), eliminated: .init(b))
   }
   return nil
}

/// Win the battle automatically
let supremeWarriors = ["Optimus Prime", "Predaking"]

/// `a` is a Supreme Warrior
func supreme(_ a: Transformer, _ b: Transformer) -> BattleOutcome? {
   _wins(a, b) { supremeWarriors.contains(a.name) }
}

/// `a` is 4+ points braver and 3+ points stronger
func hero(_ a: Transformer, _ b: Transformer) -> BattleOutcome? {
   _wins(a, b) {
      a.courage - b.courage >= 4 && a.strength - b.strength >= 3
   }
}

/// `a` is 3+ points more skilled
func expert(_ a: Transformer, _ b: Transformer) -> BattleOutcome? {
   _wins(a, b) { a.skill - b.skill >= 3 }
}

/// Evaluates the overall rating
func overall(_ a: Transformer, _ b: Transformer) -> BattleOutcome? {
   _wins(a, b) { a.overallRating > b.overallRating }
}
