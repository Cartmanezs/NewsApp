//
//  DataFetcherService.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import Foundation

class DataFetcherService {
    
    var dataFetcher: DataFetcher
    
    private let apiKey = "c20cc0c7086049e6a2d549390dbea602"
    private let topHeadLines = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    private let everything = "https://newsapi.org/v2/everything?q=bitcoin&apiKey="
    private let sources = "https://newsapi.org/v2/sources?apiKey="
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchTopHeadLines(completion: @escaping (NewsSource?) -> Void) {
        let topHeadLinesURL = topHeadLines + apiKey
        dataFetcher.fetchGenericJSONData(urlString: topHeadLinesURL, response: completion)
    }
    
    func fetchSources(completion: @escaping (NewsSource?) -> Void) {
        let sourcesURL = everything + apiKey
        dataFetcher.fetchGenericJSONData(urlString: sourcesURL, response: completion)
    }
    
    func fetchEverything(completion: @escaping (NewsSource?) -> Void) {
        let everythingURL = everything + apiKey
        dataFetcher.fetchGenericJSONData(urlString: everythingURL, response: completion)
    }
}
