//
//  UIView+Extension.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius : Double {
        get {
            self.layer.cornerRadius
        }set {
            self.layer.cornerRadius = newValue
        }
    }
}
