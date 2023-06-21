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
    case badUrl = "This error occurs when the provided URL is invalid or malformed, preventing the proper execution of the HTTP request"
    case badData = "This error indicates that the received data from the server is corrupted or not in the expected format, making it impossible to parse or use effectively."
    case parsingError = "This error occurs during the process of parsing or converting the received data into a usable format. It usually happens when the data structure or format differs from what was expected"
    case generalError = "This error is a catch-all category for any other unspecified error that may occur during the HTTP request process. It represents a general failure or issue that cannot be attributed to a specific error type."
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
