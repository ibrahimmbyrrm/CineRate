//
//  MovieDetailViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 8.06.2023.
//

import Foundation

typealias MovieBasedViewModel = MovieBased & DetailViewModelInterface

class MovieDetailViewModel : MovieBasedViewModel{
    
    var movie : Movie
    var detailViewDelegate: DetailViewInterface?
    
    required init(movie: Movie) {
        self.movie = movie
    }
    
    func viewDidLoad() {
        detailViewDelegate?.setupUI()
        detailViewDelegate?.addSubviews()
        detailViewDelegate?.setupConstraints()
    }
}


extension MovieDetailViewModel {
    var title : String {
        return movie.title
    }
    var date : String {
        return "Release Date \(movie.releaseDate)"
    }
    var overview : String {
        return movie.overview
    }
    var id : Int {
        return movie.id
    }
    var popularity : String {
        return "Popularity \(movie.popularity)"
    }
    var posterPath : String {
        return movie.posterPath
    }
}

