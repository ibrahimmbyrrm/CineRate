//
//  HomeContracts.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation
import UIKit

protocol AlertShowable {
    func showAlert(errorVC : UIViewController)
}

protocol HomeControllerInterface : AnyObject,AlertShowable{
    func reloadData()
    func prepareCollectionView()
    func setupConstraints()
    func prepareNavigationBar()
    func addSubviews()
}

protocol NavigationDelegate : AnyObject {
    func jumpToViewController(with identifier : String)
}

protocol HomeViewModelInterface {
    var service : ServiceRouter {get}
    var delegate: NavigationPerformableHomeView? { get set }
    var movieList: [Movie] { get }
    var resource: Resource<InitialData> { get set }
    
    func getData()
    func segmentChanged(_ segmentIndex : Int)
    func numberOfRows(_ section: Int) -> Int
    func changePage(_ button : UIBarButtonItem?)
    func createViewModel<T: MovieBased>(for index: Int) -> T
    func viewDidLoad()
    func signOutClicked()
    
}
enum PageButtonType {
    case next
    case previous
    case normal
}
