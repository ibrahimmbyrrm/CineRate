//
//  CommentListViewModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 10.06.2023.
//

import Foundation

class CommentListViewModel : CommentListViewModelProtocol {
    
    var movieDetailViewModel : MovieDetailViewModel
    lazy var firebaseService: FirebaseFirestoreService = FirebaseFirestoreService()
    var delegate: CommentListViewProtocol?
    var commentList : [Comment] = []
    
    init(movieDetailVM : MovieDetailViewModel) {
        self.movieDetailViewModel = movieDetailVM
    }
    
    func viewDidLoad() {
        delegate?.prepareTableView()
        delegate?.prepareNavigationBar()
        delegate?.setupBackgroundColor()
    }
    
    func fetchData() {
        FirebaseFirestoreService.shared.fetchCommentsa(movieID: movieDetailViewModel.id) { comments in
            guard let comments = comments else {return}
            self.commentList = comments
            self.delegate?.refreshData()
        }
    }
    
    func numberOfRowsInSection(_ section : Int) -> Int {
        return self.commentList.count
    }
    
    func itemAtIndex(_ index : Int) -> CommentViewModel {
        return CommentViewModel(comment: self.commentList[index])
    }
}

