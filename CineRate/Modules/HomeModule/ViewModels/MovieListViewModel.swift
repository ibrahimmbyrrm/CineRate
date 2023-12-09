//
//  MovieListViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit

class MovieListViewModel : HomeViewModelInterface {
    var service: ServiceRouter
    
    var resource = Resource<InitialData>(method: .get, listType: .popular, page: 1)
    weak var delegate : NavigationPerformableHomeView?
    
    private var cacheKey : String {
        return "\(self.resource.listType.rawValue)\(self.resource.page)"
    }
    
    var movieList = [Movie]() {
        didSet{
            self.delegate?.reloadData()
        }
    }
    
    init(service : ServiceRouter) {
        self.service = service
    }
    
   
    //MARK: - Access to Webservice and set MovieList
    func getData() {
        //If data trying to fetch is saved previously, viewModel is not going to call api.It's going to read cache for data.
        if let cachedData = CacheManager.shared.readCacheData(forKey: cacheKey) {
            self.movieList = cachedData
            return
        }
        service.callApi(resource: resource) { [weak self] result in
            switch result {
            case .success(let initialData):
                self?.movieList = initialData.results
                self?.movieList.saveOnCache(forkey: self?.cacheKey)
            case.failure(let erorr):
                DispatchQueue.main.async {
                    let alert = MCAlertController(error: erorr)
                    alert.modalPresentationStyle = .fullScreen
                    self?.delegate?.showAlert(errorVC: alert)
                    print(erorr.rawValue)
                }
            }
        }
    }
    // MARK: - CollectionView Data Source Functions
    func numberOfRows(_ section : Int) -> Int {
        return movieList.count
    }
    ///We can create both MovieViewModel and MovieDetailViewModel with one function.
    func createViewModel<T: MovieBased>(for index: Int) -> T {
        return T(movie: movieList[index])
    }
    // MARK: - viewDidLoad of HomeController
    func viewDidLoad() {
        getData()
        delegate?.addSubviews()
        delegate?.prepareCollectionView()
        delegate?.setupConstraints()
        delegate?.prepareNavigationBar()
    }
    //MARK: - Changing page by clicked button.
    func changePage(_ button : UIBarButtonItem?) {
        guard let button else {return}
        switch button.pageType {
        case .next:
            self.resource.page += 1
        case .previous:
            self.resource.page -= 1
        case .normal:
            let errorVC = MCAlertController(error: .generalError)
            errorVC.modalPresentationStyle = .fullScreen
            self.delegate?.showAlert(errorVC: errorVC)
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
    // MARK: - Sign out function
    func signOutClicked() {
        FirebaseAuthService.shared.authenticateUser(method: .signout, credentials: nil) { isSuccess in
            isSuccess ? self.delegate?.jumpToViewController(with: Constants.Identifiers.loginVcIdentifier) : nil
        }
    }
}


