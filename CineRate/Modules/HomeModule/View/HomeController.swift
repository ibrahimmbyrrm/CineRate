//
//  HomeControllerr.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit
import Firebase

typealias NavigationPerformableHomeView = HomeControllerInterface & NavigationDelegate

final class HomeController : UIViewController {
    // MARK: - Programmatic UI Objects
    private lazy var segmentedControl : UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.insertSegment(withTitle: "Popular", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Top Rated", at: 1, animated: true)
        segmented.insertSegment(withTitle: "Upcoming", at: 2, animated: true)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(nil, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmented.selectedSegmentTintColor = UIColor(red: 255/255, green: 162/255, blue: 61/255, alpha: 1)
        segmented.tintColor = .white
        return segmented
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 200)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
        return collectionView
    }()
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: nil, action: #selector(signOutClicked))
        toolbarButton.tintColor = .red
        let nextPageButton = UIBarButtonItem(image: UIImage(systemName: "arrow.right"), style: .plain, target: self, action: #selector(changePage(_:)))
        let previousPageButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(changePage(_:)))
        [nextPageButton,previousPageButton].forEach({$0.tintColor = .orange})
        toolbar.tintColor = .red
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.barTintColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        toolbar.items = [previousPageButton,flexibleSpace, toolbarButton, flexibleSpace,nextPageButton
        ]
        return toolbar
    }()
    private var listVM : HomeViewModelInterface = MovieListViewModel(service: Webservice())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listVM.delegate = self
        listVM.viewDidLoad()
    }
    
    func prepareCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func prepareNavigationBar() {
        let navigationBarBuilder = HomeNavigationBarBuilder(parentNavigationController: self.navigationController)
        navigationBarBuilder.prepareNavigationBar()
    }
    
    func addSubviews() {
        [segmentedControl,collectionView,toolbar].forEach({view.addSubview($0)})
    }
    
    func setupConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        toolbar.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    // MARK: - Selector Functions for Programmatic Buttons
    @objc private func segmentChanged(_ segment : UISegmentedControl) {
        listVM.segmentChanged(segment.selectedSegmentIndex)
        title = segment.titleForSegment(at: segment.selectedSegmentIndex)
    }
    
    @objc private func signOutClicked() {
        listVM.signOutClicked()
    }
    
    @objc private func changePage(_ sender : UIBarButtonItem) {
        listVM.changePage(sender)
    }
    
}
//MARK: - Delegate Functions
extension HomeController : NavigationPerformableHomeView {
    
    func showAlert(errorVC: UIViewController) {
        self.present(errorVC, animated: true)
    }
    //When the movieList changed, viewModel called reloadData function with protocol and our collectionView reloads data async.Also changes next and previous buttons view.
    func reloadData() {
        self.toolbar.items?[0].isHidden = !(self.listVM.resource.page > 1)
        self.toolbar.items?[4].isHidden = !(self.listVM.resource.page < 3)
        self.collectionView.reloadData()
    }
    
    func jumpToViewController(with identifier: String) {
        let loginVC = self.storyboard?.instantiateViewController(identifier: identifier) as! LoginController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
}

extension HomeController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewModel : MovieDetailViewModel = listVM.createViewModel(for: indexPath.row)
        let movieDetailController = MovieDetailController(detailVM: detailViewModel)
        navigationController?.pushViewController(movieDetailController, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVM.numberOfRows(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCollectionViewCell
        let movieVM : MovieViewModel = listVM.createViewModel(for: indexPath.row)
        cell.configureCell(viewModel: movieVM)
        return cell
    }
}

