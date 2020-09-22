//
//  UITextField+.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import UIKit

extension UITextField {
   /// Helper to get text after `textField(_:shouldChangeCharactersIn:replacementString:)`
   func textReplacing(_ string: String, in range: NSRange) -> String {
      NSString(string: text ?? "").replacingCharacters(in: range, with: string)
   }
}
