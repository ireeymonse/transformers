//
//  TransformerListViewController.swift
//  TransformersBattle
//
//  Created by Iree García on 22/09/20.
//

import UIKit

class TransformerListViewController: UIViewController {
   @IBOutlet var tableView: UITableView!

   var model = TransformerListViewModel([]) {
      didSet { tableView.reloadData() }
   }

   override func viewDidLoad() {
      super.viewDidLoad()
      if #available(iOS 13.0, *),
         let bar = navigationController?.navigationBar {
         let appearance = bar.standardAppearance
         appearance.configureWithTransparentBackground()
         bar.standardAppearance = appearance
         bar.scrollEdgeAppearance = appearance
      }

      title = model.title

      showActivityIndicator()
      DataCoordinator.fetchTransformerList { [weak self] list in
         guard let self = self else { return }
         hideActivityIndicator()
         list.map {
            self.model = TransformerListViewModel($0)
         }
      }
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // returns immediately
      DataCoordinator.fetchTransformerList(cacheOnly: true) { list in
         list.map {
            self.model = TransformerListViewModel($0)
         }
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
      model.sections[section].name
   }

   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell: TransformerRow = tableView.dequeueCell(at: indexPath)
      cell.model = model[indexPath]
      return cell
   }

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
   }
}
