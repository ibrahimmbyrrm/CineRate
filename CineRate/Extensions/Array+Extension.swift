//
//  NSCache+Extension.swift
//  CineRate
//
//  Created by İbrahim Bayram on 5.06.2023.
//

import Foundation

extension Array {
    func saveOnCache(forkey key : String?) {
        guard let key = key else {return}
        CacheManager.shared.writeOnCache(object: self as AnyObject, forKey: key as NSString)
    }
}
