//
//  Webservice.swift
//  CineRate
//
//  Created by İbrahim Bayram on 1.06.2023.
//

import Foundation

struct Webservice {
    static let shared = Webservice()
    
    func callApi<T : Codable>(resource : Resource<T>,completion : @escaping(Result<T,httpError>) -> Void ) {
        var urlRequest = URLRequest(url: resource.URL)
        urlRequest.httpMethod = resource.method.rawValue
        urlRequest.allHTTPHeaderFields = Constants.httpHeader
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if error != nil {
                completion(.failure(.badUrl))
            }
            guard let data = data else {return}
            let results = try? JSONDecoder().decode(T.self, from: data)
            guard let results = results else {
                completion(.failure(.parsingError))
                return}
            completion(.success(results))
        }.resume()
    }
    
    
    
}
