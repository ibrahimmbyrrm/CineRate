//
//  MovieListViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit
import SDWebImage
class MovieListViewModel {
    
    var movieList = [Movie]()
    
    
    let resource = Resource<InitialData>(URL: URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=2")!, method: .get)
    func getData(completion : @escaping(Bool)->Void) {
        Webservice().callApi(resource: resource) { result in
            switch result {
            case .success(let initialData):
                self.movieList = initialData.results
                completion(true)
                print(initialData.results)
            case.failure(let erorr):
                print(erorr.rawValue)
            }
        }
    }
    
    func numberOfRows(_ section : Int) -> Int {
        return movieList.count
    }
    func itemAtIndex(_ index : Int) -> MovieViewModel {
        return MovieViewModel(movie: movieList[index])
    }
    
}

struct MovieViewModel {
    let movie : Movie
    
    init(movie: Movie) {
        self.movie = movie
    }

    
}

extension MovieViewModel {
    var title : String {
        return movie.title
    }
    
    var posterImage : URL {
        if let url = URL(string: "https://image.tmdb.org/t/p/w300\(movie.poster_path)") {
            return url
        }else {
            return URL(string: "https://image.tmdb.org/t/p/w300/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg")!
        }
    }
}
