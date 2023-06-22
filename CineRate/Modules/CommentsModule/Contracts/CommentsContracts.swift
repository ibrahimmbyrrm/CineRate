//
//  CommentsContracts.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation

protocol CommentListViewModelProtocol {
    var commentList : [Comment] {get set}
    var delegate : CommentListViewProtocol? {get set}
    var firebaseService : FirebaseFirestoreService {get}
    func fetchData()
    func numberOfRowsInSection(_ section : Int) -> Int
    func itemAtIndex(_ index : Int) -> CommentViewModel
    func viewDidLoad()
}

protocol CommentListViewProtocol {
    func refreshData()
    func setupBackgroundColor()
    func prepareTableView()
    func prepareNavigationBar()
}
