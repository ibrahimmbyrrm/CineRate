//
//  HomeControllerr.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation
import UIKit
import Firebase

class HomeController : UIViewController {
    // MARK: - Programmatic UI Objects
    private let segmentedControl : UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: "Popular", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Top Rated", at: 1, animated: true)
        segmented.insertSegment(withTitle: "Upcoming", at: 2, animated: true)
        segmented.selectedSegmentIndex = 0
        segmented.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        segmented.selectedSegmentTintColor = .blue
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
        collectionView.backgroundColor = .darkGray
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
        return collectionView
    }()
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let toolbarButton = UIBarButtonItem(title: "Toolbar Button", style: .plain, target: self, action: #selector(signOutClicked))
        toolbar.tintColor = .red
        toolbar.barTintColor = UIColor(red: 173/255, green: 219/255, blue: 164/255, alpha: 1)
        toolbar.items = [flexibleSpace, toolbarButton, flexibleSpace]
        return toolbar
       }()
    // MARK: -
    
    var listVM = MovieListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        listVM.getData { isSuccess in
            isSuccess ? self.collectionView.reloadAsync() : print("fuck")
        }
        title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
    }
    
    @objc func segmentChanged(_ segment : UISegmentedControl) {
        self.title = segment.titleForSegment(at: segment.selectedSegmentIndex)
    }
    
    @objc func signOutClicked() {
        try? Auth.auth().signOut()
        let loginVC = storyboard?.instantiateViewController(identifier: "LoginController") as! LoginController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    func setupViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Previous Page", style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next Page", style: .plain, target: self, action: nil)
            
        view.addSubviewWithConstraints(segmentedControl, topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor)
        view.addSubviewWithConstraints(collectionView, topAnchor: segmentedControl.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
        view.addSubviewWithConstraints(toolbar, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor)
    }
}

extension HomeController : UICollectionViewDelegate, UICollectionViewDataSource {
    
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
