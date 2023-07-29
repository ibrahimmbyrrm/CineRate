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
        if self.title == "Next Page" {
            return .next
        }else if self.title == "Previous Page" {
            return .previous
        }else {
            return .normal
        }
    }
}
