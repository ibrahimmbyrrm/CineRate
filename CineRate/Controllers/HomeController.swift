//
//  HomeController.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import UIKit
import Firebase
import SDWebImage

class Film {
    var ad: String
    var foto: UIImage
    
    init(ad: String, foto: UIImage) {
        self.ad = ad
        self.foto = foto
    }
}

class AnaEkranCollectionViewController: UICollectionViewController {
    
    var listVM = MovieListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        listVM.getData { isSuccess in
            if isSuccess {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        setupUI()
        
    }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "FilmCell")
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOutClicked))
    }
    
    @objc func signOutClicked() {
        try? Auth.auth().signOut()
        let loginVC = storyboard?.instantiateViewController(identifier: "LoginController") as! LoginController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true)
    }
    
    // UICollectionViewDataSource metotları
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listVM.numberOfRows(section)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilmCell", for: indexPath) as! FilmCollectionViewCell
        let movieVM = listVM.itemAtIndex(indexPath.row)
        cell.filmAdLabel.text = movieVM.title
        cell.filmImageView.sd_setImage(with: movieVM.posterImage)
        
        return cell
    }
}


