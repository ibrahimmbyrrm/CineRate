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
    var detailViewDelegate : DetailViewInterface? {get set}
}

protocol DetailViewInterface {
    func addSubviews()
    func setupConstraints()
    func setupUI()
}

