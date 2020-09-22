//
//  UIView+.swift
//  TransformersBattle
//
//  Created by Iree García on 21/09/20.
//

import UIKit

extension UIView {
   @IBInspectable var borderColor: UIColor? {
      set { layer.borderColor = newValue?.cgColor }
      get { layer.borderColor?.uiColor }
   }

   @IBInspectable var borderWidth: CGFloat {
      set { layer.borderWidth = newValue }
      get { layer.borderWidth }
   }

   @IBInspectable var cornerRadius: CGFloat {
      set { layer.cornerRadius = newValue }
      get { layer.cornerRadius }
   }

   @IBInspectable var shadowColor: UIColor? {
      set {
         layer.shadowColor = newValue?.cgColor
         layer.shadowOpacity = 1
         layer.shadowRadius = 17
         layer.shadowOffset = CGSize(width: 0, height: 3)
         layer.masksToBounds = false
      }
      get { layer.shadowColor?.uiColor }
   }
}

extension CGColor {
   var uiColor: UIColor { UIColor(cgColor: self) }
}
