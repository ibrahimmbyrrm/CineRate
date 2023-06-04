//
//  MovieListViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//


//https://api.themoviedb.org/3/movie/popular?api_key=fe1595f8a047fd3679470acd2f65627e
//https://api.themoviedb.org/3/movie/top_rated?api_key=fe1595f8a047fd3679470acd2f65627e

import Foundation
import UIKit
import SDWebImage

protocol ListUpdate{
    func reloadData()
}
class MovieListViewModel {
 
    var delegate : ListUpdate!
    var movieList = [Movie]()
    var resource = Resource<InitialData>(method: .get, listType: .popular, page: 1) {
        didSet {
            print("didset worked")
            getData { isSuccess in
                self.delegate.reloadData()
            }
        }
    }
     
    func getData(completion : @escaping(Bool)->Void) {
        Webservice().callApi(resource: resource) { [weak self] result in
            switch result {
            case .success(let initialData):
                self?.movieList = initialData.results
                completion(true)
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
        if let url = URL(string: "\(Constants.imageBaseUrl)\(movie.posterPath)") {
            return url
        }else {
            return URL(string: Constants.defaultImageUrl)!
        }
    }
}
