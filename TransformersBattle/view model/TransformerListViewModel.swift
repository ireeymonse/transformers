//
//  TransformerListViewModel.swift
//  TransformersBattle
//
//  Created by Iree García on 22/09/20.
//

import UIKit

class TransformerListViewModel {
   let title = "Warriors"
   let sections: [Transformer.Team]
   let items: [[TransformerViewModel]]
   let warModel: WarViewModel

   init(_ warriors: [Transformer]) {
      let groups = Dictionary(grouping: warriors, by: { $0.team })
      sections = groups.keys.sorted()
      items = sections.map { team in
         groups[team]!.sorted { $0.rank > $1.rank }.map { TransformerViewModel($0) }
      }
      warModel = WarViewModel(between: warriors)
   }

   func sectionTitle(for section: Int) -> String {
      "\(sections[section].name)s"
   }

   subscript(_ indexPath: IndexPath) -> TransformerViewModel {
      items[indexPath.section][indexPath.row]
   }
}

extension Transformer.Team: Comparable {
   static func < (lhs: Transformer.Team, rhs: Transformer.Team) -> Bool {
      lhs == .decepticon && rhs == .autobot
   }
}
