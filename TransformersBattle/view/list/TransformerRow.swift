//
//  TransformerRow.swift
//  TransformersBattle
//
//  Created by Iree García on 22/09/20.
//

import UIKit

class TransformerRow: UITableViewCell {
   @IBOutlet var nameLabel: UILabel!
   @IBOutlet var specsLabel: UILabel!
   @IBOutlet var symbolImageView: UIImageView!

   override func awakeFromNib() {
      super.awakeFromNib()
      selectedBackgroundView = UIView()
      selectedBackgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.2)
   }

   var model: TransformerViewModel? {
      didSet {
         // optional in case outlets not loaded yet
         nameLabel?.text = model?.name
         // FIXME: show in separate views
         specsLabel?.text = model?.relevantSpecsList.map {
            "\($0.label): \($0.valueText)"
         }.joined(separator: ", ")
         symbolImageView.image = model?.teamSymbol
      }
   }
}
