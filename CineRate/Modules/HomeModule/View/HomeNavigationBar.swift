//
//  HomeNavigationBar.swift
//  CineRate
//
//  Created by İbrahim Bayram on 30.07.2023.
//

import Foundation
import UIKit

class HomeNavigationBarBuilder {
    
    weak var parentNavigationController : UINavigationController?
    
    init(parentNavigationController: UINavigationController?) {
        self.parentNavigationController = parentNavigationController
    }
    
    
    func prepareNavigationBar() {
        guard let parentNavigationController else {return}
        var titleAttributes = parentNavigationController.navigationBar.titleTextAttributes ?? [:]
            titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor(red: 255/255, green: 162/255, blue: 61/255, alpha: 1)
        parentNavigationController.navigationBar.titleTextAttributes = titleAttributes
    }
}
