//
//  UIView+Extension.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit

extension UIView {
    func addSubviewWithConstraints(_ view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, leadingAnchor: NSLayoutXAxisAnchor? = nil, trailingAnchor: NSLayoutXAxisAnchor? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        if let topAnchor = topAnchor {
            view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }
        
        if let leadingAnchor = leadingAnchor {
            view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        }
        
        if let trailingAnchor = trailingAnchor {
            view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
        
        if let bottomAnchor = bottomAnchor {
            view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
    
    @IBInspectable var cornerRadius : Double {
        get {
            self.layer.cornerRadius
        }set {
            self.layer.cornerRadius = newValue
        }
    }
}
