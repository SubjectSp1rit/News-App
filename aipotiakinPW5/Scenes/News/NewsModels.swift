//
//  NewsModels.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

enum Models {
    struct ArticleModel: Decodable {
        var newsId: Int?
        var title: String?
        var announce: String?
        var img: ImageContainer?
        var requestId: String?
        var articleUrl: URL? {
            let requestId = requestId ?? ""
            let newsId = newsId ?? 0
            return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
        }
    }
    
    struct ImageContainer: Decodable {
        var url: URL?
    }
    
    struct NewsPage: Decodable {
        var news: [ArticleModel]?
        var requestId: String?
        mutating func passTheRequestId() {
            for i in 0..<(news?.count ?? 0) {
                news?[i].requestId = requestId
            }
        }
    }
    
    enum FetchArticles {
        struct Request { }
        struct Response {
            var articles: [ArticleModel]
        }
        struct ViewModel { }
    }
    
    enum FetchImage {
        class Request {
            var url: URL
            var completion: ((UIImage?) -> Void)
            
            init(url: URL, completion: @escaping (UIImage?) -> Void) {
                self.url = url
                self.completion = completion
            }
        }
        struct Response { }
    }
}
