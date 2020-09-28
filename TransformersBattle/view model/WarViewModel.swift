//
//  WarViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import UIKit

class WarViewModel {
   let battles: [BattleOutcome]
   let battleCountText: String
   let outcomeText: String
   let survivorsText: String
   let winningTeamSymbol: UIImage?
   let backgroundColor: UIColor

   init(between warriors: [Transformer]) {
      switch WarOutcome.for(warriors) {
      case let .victory(battles, winningTeam, victors, rivalSurvivors):
         self.battles = battles

         var list = victors.joined(separator: ", ")
         outcomeText = "Winning team (\(winningTeam.name)s): \(list)"

         if rivalSurvivors.isEmpty {
            survivorsText = ""
         } else {
            list = rivalSurvivors.joined(separator: ", ")
            survivorsText = "Survivors from the losing team (\(winningTeam.rival.name)s): \(list)"
         }
         winningTeamSymbol = winningTeam.symbol
         backgroundColor = .white

      case let .tie(battles):
         self.battles = battles
         outcomeText = "It's a Tie!"
         survivorsText = ""
         winningTeamSymbol = nil
         backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)

      case .mayhem:
         battles = []
         outcomeText = "Mayhem!"
         survivorsText = "No survivors."
         winningTeamSymbol = nil
         backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
      }

      battleCountText = battles.isEmpty ? "" :
         "\(battles.count) battle\(battles.count == 1 ? "" : "s")"
   }
}

enum WarOutcome {
   case victory(battles: [BattleOutcome],
                winningTeam: Transformer.Team,
                victors: [String],
                rivalSurvivors: [String])
   case tie(battles: [BattleOutcome])
   case mayhem

   static func `for`(_ warriors: [Transformer]) -> WarOutcome {
      // get teams, sorted by higher rank
      let all = warriors.sorted { $0.rank > $1.rank }
      let decepticons = all.filter { $0.team == .decepticon }
      let autobots = all.filter { $0.team == .autobot }

      // find battle outcomes
      var battles = [BattleOutcome]()
      var casualties = [TransformerViewModel]()
      for (a, b) in zip(autobots, decepticons) {
         let battle = BattleOutcome(between: a, and: b)
         // kill everyone?
         if case .mayhem = battle {
            return .mayhem
         }
         battles.append(battle)
         casualties.append(contentsOf: battle.eliminated)
      }
      // find winning team
      let autobotsDead = casualties.filter { $0.team == .autobot }.count
      let decepticonsDead = casualties.count - autobotsDead
      // tie?
      if autobotsDead == decepticonsDead {
         return .tie(battles: battles)
      }

      let winningTeam = autobotsDead > decepticonsDead ?
         Transformer.Team.decepticon : .autobot

      let victors = battles.filter { $0.victor?.team == winningTeam }
         .compactMap { $0.victor?.name }

      let rivals = (winningTeam == .autobot ? decepticons : autobots)
      let survivors = rivals[battles.count...].map { $0.name }

      return .victory(battles: battles, winningTeam: winningTeam,
                      victors: victors, rivalSurvivors: survivors)
   }
}
