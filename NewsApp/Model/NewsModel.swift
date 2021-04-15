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
        let source: Source
        let author: String?
        let title: String?
        let description: String?
        let url: URL?
        let urlToImage: URL?
        let publishedAt: String

        struct Source: Decodable {
            let id: String?
            let name: String?
        }
    }

    private enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case articles
    }
}
