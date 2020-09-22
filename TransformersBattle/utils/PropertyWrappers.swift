//
//  PropertyWrappers.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import Foundation

@propertyWrapper
struct SecureStorage {
   private let key: String

   init(key: String) {
      self.key = key
   }

   var wrappedValue: String? {
      // FIXME: use keychain. Implemented like this for speed
      get { UserDefaults.standard.string(forKey: key) }
      set { UserDefaults.standard.set(newValue, forKey: key) }
   }
}
