//
//  DetailContracts.swift
//  CineRate
//
//  Created by İbrahim Bayram on 21.06.2023.
//

import Foundation

protocol MovieBased {
    var movie : Movie {get set}
    init(movie: Movie)
}

protocol DetailViewModelInterface {
    func viewDidLoad()
    func seeCommentsTapped()
    func backToHome()
    var detailViewDelegate : DetailViewInterface? {get set}
}

protocol DetailViewInterface : AnyObject {
    func addSubviews()
    func setupConstraints()
    func setupUI()
}

