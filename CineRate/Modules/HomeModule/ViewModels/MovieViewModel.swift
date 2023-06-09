//
//  MovieViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 10.06.2023.
//

import Foundation

struct MovieViewModel : MovieBased {
    var movie : Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
}

extension MovieViewModel {
    var title : String {
        return movie.title
    }
    
    var posterImage : URL {
        if let url = URL(string: "\(Constants.imageBaseUrl)\(movie.posterPath)") {
            return url
        }else {
            return URL(string: Constants.defaultImageUrl)!
        }
    }
}
