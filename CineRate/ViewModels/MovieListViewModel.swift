//
//  MovieListViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit
import SDWebImage

protocol MovieListViewModelProtocol {
    var service : ServiceRouter {get}
    var delegate: ListUpdate? { get set }
    var movieList: [Movie] { get }
    var resource: Resource<InitialData> { get set }
    var cacheKey : String {get}
        
    func getData()
    func segmentChanged(_ segmentIndex : Int)
    func numberOfRows(_ section: Int) -> Int
    func changePage(_ buttonTitle : String)
    func createViewModel<T: MovieBased>(for index: Int) -> T
}

class MovieListViewModel : MovieListViewModelProtocol {
    
    init() {
        getData()
    }
    
    var service: ServiceRouter = Webservice()
    var resource = Resource<InitialData>(method: .get, listType: .popular, page: 1)
    var delegate : ListUpdate?
    var cacheKey : String {
        return "\(self.resource.listType.rawValue)\(self.resource.page)"
    }
    var movieList = [Movie]() {
        didSet{
            self.delegate?.reloadData()
        }
    }
    //MARK: - Access to Webservice and set MovieList
    func getData() {
        
        //If data trying to fetch is saved previously, viewModel is not going to call api.It's going to read cache for data.
        if let cachedData = CacheManager.shared.readCacheData(forKey: cacheKey) {
            self.movieList = cachedData
            print("Data has been fetched from CACHE")
            return
        }
        
        service.callApi(resource: resource) { [weak self] result in
            switch result {
            case .success(let initialData):
                print("ViewModel accessed to WebService")
                self?.movieList = initialData.results
                self?.movieList.saveOnCache(forkey: self?.cacheKey)
            case.failure(let erorr):
                print(erorr.rawValue)
            }
        }
    }

    func numberOfRows(_ section : Int) -> Int {
        return movieList.count
    }
    //We can create both MovieViewModel and MovieDetailViewModel with one function.
    func createViewModel<T: MovieBased>(for index: Int) -> T {
        return T(movie: movieList[index])
    }
    //MARK: - Changing page by clicked button.
    func changePage(_ buttonTitle : String) {
        switch buttonTitle {
        case "Next Page":
            self.resource.page += 1
        case "Previous Page":
            self.resource.page -= 1
        default:
            break
        }
        getData()
    }
    //MARK: - Change list type by segmented control index.
    func segmentChanged(_ segmentIndex : Int) {
        switch segmentIndex {
        case 0:
            self.resource.listType = .popular
        case 1:
            self.resource.listType = .topRated
        case 2:
            self.resource.listType = .upcoming
        default:
            break
        }
        self.resource.page = 1
        getData()
    }

}

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
