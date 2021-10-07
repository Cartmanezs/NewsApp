//
//  NewsModel.swift
//  NewsApp
//
//  Created by Ingvar on 15.04.2021.
//

import Foundation

struct NewsSource: Decodable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]
    
    struct Article: Decodable {
        let source: Source?
        let author: String?
        let title: String?
        let description: String?
        let url: URL?
        let urlToImage: URL?
        let publishedAt: String?
        
        init(source: Source? = nil,
             title: String? = nil,
             author: String? = nil,
             description: String? = nil,
             url: URL? = nil,
             urlToImage: URL? = nil,
             publishedAt: String? = nil) {
                self.source = nil
                self.title = title
                self.author = author
                self.description = description
                self.url = url
                self.urlToImage = urlToImage
                self.publishedAt = publishedAt
        }

        struct Source: Decodable {
            let id: String?
            let name: String?
        }
    }
}
