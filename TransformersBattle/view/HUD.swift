//
//  HUD.swift
//  TransformersBattle
//
//  Created by Iree García on 22/09/20.
//

import UIKit

class ActivityIndicatorController: UIViewController {
   static func create() -> ActivityIndicatorController? {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      return storyboard.instantiateViewController(withIdentifier: "hud") as? ActivityIndicatorController
   }
}

func showActivityIndicator() {
   DispatchQueue.main.async {
      let root = UIApplication.shared.windows.first?.rootViewController
      if root?.presentedViewController is ActivityIndicatorController {
         return
      }
      if let hud = ActivityIndicatorController.create() {
         root?.present(hud, animated: false)
      }
   }
}

func hideActivityIndicator() {
   DispatchQueue.main.async {
      let root = UIApplication.shared.windows.first?.rootViewController
      if root?.presentedViewController is ActivityIndicatorController {
         root?.dismiss(animated: false)
      }
   }
}

extension UIViewController {
   func alert(_ message: String?, title: String? = nil) {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .cancel))
      present(alert, animated: true)
   }
}
