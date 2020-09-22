//
//  WarOutcomeViewController.swift
//  TransformersBattle
//
//  Created by Iree García on 22/09/20.
//

import UIKit

// example of nib-based controller
class WarOutcomeViewController: UIViewController {
   @IBOutlet var battleCountLabel: UILabel!
   @IBOutlet var outcomeLabel: UILabel!
   @IBOutlet var survivorsLabel: UILabel!
   @IBOutlet var symbolImageView: UIImageView!

   var model = WarViewModel(between: [])

   convenience init(model: WarViewModel) {
      self.init()
      self.model = model
      modalPresentationStyle = .formSheet
      preferredContentSize = CGSize(width: 300, height: 460)
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      view.cornerRadius = 24

      battleCountLabel.text = model.battleCountText
      battleCountLabel.isHidden = model.battleCountText.isEmpty
      outcomeLabel.text = model.outcomeText
      survivorsLabel.text = model.survivorsText
      survivorsLabel.isHidden = model.survivorsText.isEmpty

      view.backgroundColor = model.backgroundColor
      symbolImageView.image = model.winningTeamSymbol
   }

   @IBAction func dismissButtonHit(_: Any) {
      dismiss(animated: true)
   }
}
