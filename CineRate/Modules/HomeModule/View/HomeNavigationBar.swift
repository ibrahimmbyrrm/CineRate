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
    
    
    func prepareNavigationBar(target: Any?, previousPageSelector: Selector?, nextPageSelector: Selector?) {
        guard let parentNavigationController else {return}
        var titleAttributes = parentNavigationController.navigationBar.titleTextAttributes ?? [:]
            titleAttributes[NSAttributedString.Key.foregroundColor] = UIColor(red: 255/255, green: 162/255, blue: 61/255, alpha: 1)
        parentNavigationController.navigationBar.titleTextAttributes = titleAttributes

        let previousPageButton = UIBarButtonItem(title: "Previous Page", style: .plain, target: target, action: previousPageSelector)
        previousPageButton.isHidden = true
        customizeBarButtonItem(previousPageButton)

        let nextPageButton = UIBarButtonItem(title: "Next Page", style: .plain, target: target, action: nextPageSelector)
        customizeBarButtonItem(nextPageButton)

        parentNavigationController.topViewController?.navigationItem.leftBarButtonItem = previousPageButton
        parentNavigationController.topViewController?.navigationItem.rightBarButtonItem = nextPageButton
    }

    private func customizeBarButtonItem(_ buttonItem: UIBarButtonItem) {
        var buttonAttributes = buttonItem.titleTextAttributes(for: .normal) ?? [:]
        buttonAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
        buttonAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16)
        buttonItem.setTitleTextAttributes(buttonAttributes, for: .normal)
    }
}
