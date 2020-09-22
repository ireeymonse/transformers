//
//  EditSpecRow.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import UIKit

class EditSpecRow: UITableViewCell {
   @IBOutlet var specNameLabel: UILabel!
   @IBOutlet var valueLabel: UILabel!
   @IBOutlet var valueSlider: UISlider!

   var model: SpecViewModel? {
      didSet {
         // optional in case outlets not loaded yet
         specNameLabel?.text = model?.label
         valueLabel?.text = model?.valueText
         valueSlider?.value = model?.value ?? 0
      }
   }

   @IBAction func sliderValueChanged(_ sender: UISlider) {
      model?.value = sender.value
      valueLabel.text = model?.valueText
   }
}
