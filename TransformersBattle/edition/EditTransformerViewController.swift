//
//  EditTransformerViewController.swift
//  TransformersBattle
//
//  Created by Iree García on 19/09/20.
//

import UIKit

class EditTransformerViewController: UIViewController {
   @IBOutlet var backgroundImageView: UIImageView!
   @IBOutlet var symbolImageView: UIImageView!

   @IBOutlet var symbolTopOffset: NSLayoutConstraint!

   // empty by default
   var model = TransformerViewModel()

   override func viewDidLoad() {
      super.viewDidLoad()

      // DEMO CODE
      model.name = "DEMO BOT"
      model.team = .autobot
      TransformerSpec.allCases.forEach { model[$0] = 4 }
      model.save { error in
         print(#function, "error?", error)
      }
   }

   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      symbolTopOffset.constant = navigationController?.navigationBar.frame.height ?? 0
   }

   @IBAction func switchSide(_: UISegmentedControl) {
      // TODO:
   }
}
