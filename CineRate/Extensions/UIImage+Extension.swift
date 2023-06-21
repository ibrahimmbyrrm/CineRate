//
//  UIImage+Extension.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString : String) {
        guard let url = URL(string: urlString) else {return}
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
