//
//  MovieModel.swift
//  CineRate
//
//  Created by İbrahim Bayram on 4.06.2023.
//

import Foundation

struct InitialData : Codable {
    let page : Int
    let results : [Movie]
    
}

struct Movie : Codable {
    let title : String
    let poster_path : String
}
