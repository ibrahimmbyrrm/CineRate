//
//  NetworkHelper.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation

enum httpError : String, Error {
    case badUrl = "Invalid URL"
    case badData = "Invalid Data"
    case parsingError = "Parsing Error"
}

enum httpMethod : String {
    case get = "GET"
    case post = "POST"
}

class Resource<T> {
    
    var URL : URL
    var method : httpMethod
    
    init(URL: URL, method: httpMethod) {
        self.URL = URL
        self.method = method
    }
}
