//
//  AppDelegate.swift
//  TransformersBattle
//
//  Created by Iree García on 17/09/20.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var window: UIWindow?

   func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // ensure AllSpark is available
      API().ensureAllSpark()
      return true
   }
}
