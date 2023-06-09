//
//  MCLabel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 8.06.2023.
//

import Foundation
import UIKit

class MCLabel : UILabel {

    init() {
        super.init(frame: .zero)
        self.layer.borderWidth = 3.0
        self.textColor = UIColor.orange
        self.font = UIFont.systemFont(ofSize: 20)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red: 48/255, green: 48/255, blue: 48/255, alpha: 1)
        self.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
