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
    static let API_KEY = ProcessInfo.processInfo.environment["API_KEY"] as! String
    static let httpHeader = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZTE1OTVmOGEwNDdmZDM2Nzk0NzBhY2QyZjY1NjI3ZSIsInN1YiI6IjYzZDY1ZDg2OTU1YzY1MDBhODQxMjQyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.JAWjGs_vrbfsq66nPQQ_XpqneBn9NR-k_fM0RiON7w4",
        "accept": "application/json"
    ]
    
}
