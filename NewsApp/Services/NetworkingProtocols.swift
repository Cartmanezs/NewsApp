//
//  NetworkingProtocols.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import Foundation

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, ErrorType?) -> Void)
}

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
}

enum ErrorType: Error {
    case optionalUnwrapError
    case noData
}
