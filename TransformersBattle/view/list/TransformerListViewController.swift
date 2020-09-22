//
//  TransformerListViewController.swift
//  TransformersBattle
//
//  Created by Iree García on 22/09/20.
//

import UIKit

class TransformerListViewController: UIViewController {
   @IBOutlet var tableView: UITableView!
   @IBOutlet var nuclearButton: UIButton!

   var model = TransformerListViewModel([]) {
      didSet { tableView.reloadData() }
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      if let bar = navigationController?.navigationBar {
         if #available(iOS 13.0, *) {
            let appearance = bar.standardAppearance
            appearance.configureWithTransparentBackground()
            bar.standardAppearance = appearance
            bar.scrollEdgeAppearance = appearance
         } else {
            bar.backgroundColor = .clear
            bar.shadowImage = UIImage()
            bar.setBackgroundImage(UIImage(), for: .default)
         }
      }

      title = model.title
      nuclearButton.setTitle(model.warActionTitle, for: .normal)
      reload(fromNetwork: true)
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      reload()
   }

   func reload(fromNetwork: Bool = false) {
      if fromNetwork {
         showActivityIndicator()
      }
      DataCoordinator.fetchTransformerList(cacheOnly: !fromNetwork) { [weak self] list in
         guard let self = self else { return }
         hideActivityIndicator()
         list.map {
            self.model = TransformerListViewModel($0)
         }
      }
   }

   func attemptDeleting(item: TransformerViewModel) {
      confirm(item.deleteConfirmationMessage, title: item.deleteConfirmationTitle,
              action: ("Delete", .destructive)) { confirmed in
         guard confirmed else {
            return
         }
         showActivityIndicator()
         item.delete { [weak self] error in
            guard let self = self else { return }
            hideActivityIndicator()
            if error != nil {
               self.alert(item.deleteErrorMessage, title: item.deleteErrorTitle)
            } else {
               self.reload()
            }
         }
      }
   }

   @IBAction func nuclearButtonHit(_: Any) {
      if model.items.isEmpty {
         performSegue(withIdentifier: "new transformer", sender: nil)
      } else {
         let war = WarOutcomeViewController(model: model.warModel)
         present(war, animated: true)
      }
   }

   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let controller = segue.destination as? EditTransformerViewController,
         let cell = sender as? UITableViewCell,
         let indexPath = tableView.indexPath(for: cell) {
         // send a copy not to affect view model until saved
         controller.model = model[indexPath].copy()
      }
   }
}

extension TransformerListViewController: UITableViewDataSource, UITableViewDelegate {
   func numberOfSections(in _: UITableView) -> Int {
      model.sections.count
   }

   func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
      model.items[section].count
   }

   func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
      model.sectionTitle(for: section)
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: TransformerRow = tableView.dequeueCell(at: indexPath)
      cell.model = model[indexPath]
      return cell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }

   func tableView(_: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         attemptDeleting(item: model[indexPath])
      }
   }
}
