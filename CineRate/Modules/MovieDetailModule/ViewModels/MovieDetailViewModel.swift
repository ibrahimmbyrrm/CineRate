//
//  MovieDetailViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 8.06.2023.
//

import Foundation
import UIKit

typealias MovieBasedViewModel = MovieBased & DetailViewModelInterface

class MovieDetailViewModel : MovieBasedViewModel{
    
    var movie : Movie
    var detailViewDelegate: DetailViewInterface?
    
    required init(movie: Movie) {
        self.movie = movie
    }
    
    func viewDidLoad() {
        detailViewDelegate?.setupUI()
        detailViewDelegate?.addSubviews()
        detailViewDelegate?.setupConstraints()
    }
    
    func seeCommentsTapped() {
        let commentsTableViewController = MovieCommentsTableViewController()
        commentsTableViewController.commentListVM = CommentListViewModel(movieDetailVM: self,firebaseService: FirebaseFirestoreService.shared)
        commentsTableViewController.selectedVM = self
        if let mainVC = (detailViewDelegate as? UIViewController) {
            mainVC.navigationController?.pushViewController(commentsTableViewController, animated: true)
        }

    }
    func backToHome() {
        if let mainVC = (detailViewDelegate as? UIViewController) {
            mainVC.navigationController?.popViewController(animated: true)
        }
    }
}


extension MovieDetailViewModel {
    var title : String {
        return movie.title
    }
    var date : String {
        return "Release Date \(movie.releaseDate)"
    }
    var overview : String {
        return movie.overview
    }
    var id : Int {
        return movie.id
    }
    var popularity : String {
        return "Popularity \(movie.popularity)"
    }
    var posterPath : String {
        return movie.posterPath
    }
}

