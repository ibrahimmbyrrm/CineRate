//
//  HomeContracts.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation

protocol HomeControllerInterface{
    func reloadData()
    func showAlert(error : httpError)
    func prepareCollectionView()
    func setupViews()
}

protocol NavigationDelegate {
    func jumpToViewController(with identifier : String)
}

protocol HomeViewModelInterface {
    var service : ServiceRouter {get}
    var delegate: NavigationPerformableHomeView? { get set }
    var movieList: [Movie] { get }
    var resource: Resource<InitialData> { get set }
    var cacheKey : String {get}
    
    func getData()
    func segmentChanged(_ segmentIndex : Int)
    func numberOfRows(_ section: Int) -> Int
    func changePage(_ buttonTitle : String?)
    func createViewModel<T: MovieBased>(for index: Int) -> T
    func viewDidLoad()
    func signOutClicked()
    
}
