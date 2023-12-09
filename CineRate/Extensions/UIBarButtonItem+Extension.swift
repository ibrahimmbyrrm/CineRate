//
//  UIBarButtonItem+Ext.swift
//  CineRate
//
//  Created by İbrahim Bayram on 30.07.2023.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    var pageType : PageButtonType {
        if self.image == UIImage(systemName: "arrow.right") {
            return .next
        }else if self.image == UIImage(systemName: "arrow.left") {
            return .previous
        }else {
            return .normal
        }
    }
}
