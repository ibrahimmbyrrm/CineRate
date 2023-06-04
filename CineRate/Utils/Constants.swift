//
//  Constants.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation

struct Constants {
    
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w300"
    static let moviesBaseUrl = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"
    static let defaultImageUrl = "https://image.tmdb.org/t/p/w300/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
    
    static let httpHeader = [
        "Authorization": "Bearer \(String(describing: ProcessInfo.processInfo.environment["API_KEY"]))"
    ]
    
}
