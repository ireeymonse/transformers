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
   @IBOutlet var teamSwitch: UISegmentedControl!
   @IBOutlet var nameTextField: UITextField!
   @IBOutlet var tableView: UITableView!
   @IBOutlet var saveButton: UIButton!
   @IBOutlet var symbolTopOffset: NSLayoutConstraint!

   // empty by default
   var model = TransformerViewModel()
   private var specs = [SpecViewModel]()

   override func viewDidLoad() {
      super.viewDidLoad()
      reload()
   }

   override func viewWillLayoutSubviews() {
      super.viewWillLayoutSubviews()
      symbolTopOffset.constant = navigationController?.navigationBar.frame.height ?? 0
   }

   /// Present the model onscreen
   func reload() { // TODO: animated?
      title = model.title
      navigationItem.title = model.title
      teamSwitch.selectedSegmentIndex = model.team == .autobot ? 0 : 1
      symbolImageView.image = model.teamSymbol
      backgroundImageView.image = model.teamEditionBackground
      specs = model.specsList
      tableView.reloadData()
      saveButton.isEnabled = model.isValid
   }

   @IBAction func teamSwitchChanged(_ control: UISegmentedControl) {
      model.team = control.selectedSegmentIndex == 0 ?
         .autobot : .decepticon
      reload()
   }

   @IBAction func saveButtonHit(_: UIButton) {
      showActivityIndicator()
      model.save { [weak self] error in
         guard let self = self else { return }
         hideActivityIndicator()
         if error != nil {
            self.alert(self.model.saveErrorMessage, title: self.model.saveErrorTitle)
         } else {
            self.navigationController?.popViewController(animated: true)
         }
      }
   }
}

extension EditTransformerViewController: UITableViewDataSource, UITableViewDelegate {
   func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
      specs.count
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: EditSpecRow = tableView.dequeueCell(at: indexPath)
      cell.model = specs[indexPath.row]
      return cell
   }
}

extension EditTransformerViewController: UITextFieldDelegate {
   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      model.name = textField.textReplacing(string, in: range)
      // reload button here, since only name affects validity
      saveButton.isEnabled = model.isValid
      return true
   }
}
