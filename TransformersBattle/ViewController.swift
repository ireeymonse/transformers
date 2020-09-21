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

      // DEMO CODE
      DataCoordinator.fetch { (result: [CachedTransformer]) in
         print(result)
      }
      API().getTransformers { response in
         print("raw", response.string)
         print("decoded", try? response.decode(as: Transformer.List.self))
      }
   }
}
