//
//  NetworkHelper.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation

enum listType : String {
    case topRated = "top_rated"
    case popular = "popular"
    case upcoming = "upcoming"
}

enum httpError : String, Error {
    case badUrl = "Invalid URL"
    case badData = "Invalid Data"
    case parsingError = "Parsing Error"
}

enum httpMethod : String {
    case get = "GET"
    case post = "POST"
}
//https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1
class Resource<T> {
    var method : httpMethod
    var listType : listType
    var page : Int
    var baseURL : URL {
        return URL(string: "https://api.themoviedb.org/3/movie/\(listType.rawValue)?language=en-US&page=\(page)")!
    }
    
    init(method: httpMethod, listType: listType, page: Int) {
        self.method = method
        self.listType = listType
        self.page = page
    }
}
