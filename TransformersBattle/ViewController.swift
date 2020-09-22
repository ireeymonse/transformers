//
//  ViewController.swift
//  TransformersBattle
//
//  Created by Iree García on 17/09/20.
//

import UIKit

class ViewController: UIViewController {
   override func viewDidLoad() {
      super.viewDidLoad()
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      // DEMO CODE
      showActivityIndicator()
      API().getTransformers { response in
         hideActivityIndicator()
         print("raw", response.string)
      }
   }
}
