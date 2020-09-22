//
//  UITableView+.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import UIKit

protocol Reusable {
   static var reuseID: String { get }
}

extension UITableViewCell: Reusable {
   static var reuseID: String { String(describing: self) }
}

extension UITableView {
   func register(_ cell: UITableViewCell.Type) {
      let nib = UINib(nibName: cell.reuseID, bundle: nil)
      register(nib, forCellReuseIdentifier: cell.reuseID)
   }

   /// Dequeues a cel of the specified class, using its `reuseID`
   func dequeueCell<Cell: UITableViewCell>(at indexPath: IndexPath) -> Cell {
      if let cell = dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as? Cell {
         return cell
      }
      fatalError("Could not dequeue \(Cell.self)")
   }
}
