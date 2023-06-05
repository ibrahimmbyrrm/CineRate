//
//  Constants.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
//https://api.themoviedb.org/3/movie/top_rated?api_key=fe1595f8a047fd3679470acd2f65627e
struct Constants {
    
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w300"
    static let defaultImageUrl = "https://image.tmdb.org/t/p/w300/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
    
    static let httpHeader = [
        "Authorization": "\(ProcessInfo.processInfo.environment["AUTH"] ?? "")",
        
        "accept": "application/json"
    ]
    
}
