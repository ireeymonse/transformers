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

   override func viewDidLoad() {
      super.viewDidLoad()
   }

   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      symbolTopOffset.constant = navigationController?.navigationBar.frame.height ?? 0
   }

   @IBAction func switchSide(_: UISegmentedControl) {
      // TODO:
   }
}
