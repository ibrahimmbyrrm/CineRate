//
//  HomeControllerr.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit
import Firebase

protocol ListUpdate{
    func reloadData()
}


class HomeController : UIViewController {
    // MARK: - Programmatic UI Objects
    private let segmentedControl : UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: "Popular", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Top Rated", at: 1, animated: true)
        segmented.insertSegment(withTitle: "Upcoming", at: 2, animated: true)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmented.selectedSegmentTintColor = UIColor(red: 255/255, green: 162/255, blue: 61/255, alpha: 1)
        segmented.tintColor = .white
        return segmented
    }()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let itemWidth = (UIScreen.main.bounds.width - (spacing * 3)) / 2
        layout.itemSize = CGSize(width: itemWidth, height: 200)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
        return collectionView
    }()
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutClicked))
        toolbar.tintColor = .red
        toolbar.barTintColor = UIColor(red: 38/255, green: 38/255, blue: 38/255, alpha: 1)
        toolbar.items = [flexibleSpace, toolbarButton, flexibleSpace]
        return toolbar
    }()
    
    private var listVM : MovieListViewModelProtocol = MovieListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        listVM.delegate = self
       
        
        title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    func setupViews() {
        if let navigationBar = self.navigationController?.navigationBar {
            // navigationItem'ın titleTextAttributes özelliğini alın
            var attributes = navigationBar.titleTextAttributes ?? [:]
            // Title rengini kırmızı olarak ayarlayın
            attributes[NSAttributedString.Key.foregroundColor] = UIColor(red: 255/255, green: 162/255, blue: 61/255, alpha: 1)
            // navigationItem'ın titleTextAttributes özelliğini güncelleyin
            navigationBar.titleTextAttributes = attributes
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page", style: .plain, target: self, action: #selector(changePage(_:)))
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page", style: .plain, target: self, action: #selector(changePage(_:)))
        var attributes = navigationItem.leftBarButtonItem!.titleTextAttributes(for: .normal) ?? [:]
        attributes[NSAttributedString.Key.foregroundColor] = UIColor.red
        attributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 16)
        navigationItem.leftBarButtonItem!.setTitleTextAttributes(attributes, for: .normal)
        view.addSubviewWithConstraints(segmentedControl, topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor)
        view.addSubviewWithConstraints(collectionView, topAnchor: segmentedControl.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        view.addSubviewWithConstraints(toolbar, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
    }
    // MARK: - Selector Functions for Programmatic Buttons
    @objc func segmentChanged(_ segment : UISegmentedControl) {
        listVM.segmentChanged(segment.selectedSegmentIndex)
        title = segment.titleForSegment(at: segment.selectedSegmentIndex)
    }
    
    @objc func signOutClicked() {
        FirebaseAuthService.shared.authenticateUser(method: .signout, credentials: nil) { isSuccess in
            let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginController") as! LoginController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        }
    }
    
    @objc func changePage(_ sender : UIBarButtonItem) {
        guard let title = sender.title else {return}
        listVM.changePage(title)
    }
    
}

extension HomeController : UICollectionViewDelegate, UICollectionViewDataSource, ListUpdate{
    //When the movieList changed, viewModel called reloadData function with protocol and our collectionView reloads data async.Also changes next and previous buttons view.
    func reloadData() {
        DispatchQueue.main.async {
                self.navigationItem.leftBarButtonItem?.isHidden = !(self.listVM.resource.page > 1)
                self.navigationItem.rightBarButtonItem?.isHidden = !(self.listVM.resource.page < 2)
        }
        self.collectionView.reloadAsync()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destVC = FilmDetailViewController(film: listVM.movieList[indexPath.row])
        self.present(destVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVM.numberOfRows(section)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCollectionViewCell
        let movieVM = listVM.itemAtIndex(indexPath.row)
        cell.configureCell(viewModel: movieVM)
        return cell
    }
}
