//
//  CacheManager.swift
//  CineRate
//
//  Created by İbrahim Bayram on 5.06.2023.
//

import Foundation

final class CacheManager {
    
    static let shared = CacheManager()
    private let cache = NSCache<NSString,AnyObject>()
    
    func readCacheData(forKey key : String) -> [Movie]? {
        return cache.object(forKey: key as NSString) as? [Movie]
    }
    
    func writeOnCache(object : AnyObject, forKey key : NSString) {
        cache.setObject(object, forKey: key)
    }
}
