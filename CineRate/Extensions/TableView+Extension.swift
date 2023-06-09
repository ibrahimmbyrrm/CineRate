//
//  TableView+Extension.swift
//  CineRate
//
//  Created by İbrahim Bayram on 10.06.2023.
//

import Foundation
import UIKit

extension UITableView {
    func reloadAsync() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
