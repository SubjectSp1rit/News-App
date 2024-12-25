//
//  NewsModels.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

enum Models {
    struct ArticleModel: Decodable, Encodable {
        var newsId: Int?
        var title: String?
        var announce: String?
        var img: ImageContainer?
        var sourceLink: String?
        var timeOfReading: String?
        var date: String?
        var requestId: String?
        var articleUrl: URL? {
            let requestId = requestId ?? ""
            let newsId = newsId ?? 0
            return URL(string: "https://news.myseldon.com/ru/news/index/\(newsId)?requestId=\(requestId)")
        }
    }
    
    struct ImageContainer: Decodable, Encodable {
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
            var pageIndex: Int
        }
        struct ViewModel { }
    }
    
    enum FetchMoreArticles {
        struct Request { }
        struct Response {
            var pageIndex: Int
        }
        struct ViewModel {
            var pageIndex: Int
        }
    }
    
    enum FetchImage {
        struct Request {
            var url: URL
            var indexPath: IndexPath
        }
        struct Response {
            var url: URL
            var fetchedImage: UIImage
            var indexPath: IndexPath
        }
        struct ViewModel {
            var url: URL
            var fetchedImage: UIImage
            var indexPath: IndexPath
        }
    }
    
    enum ShareSheet {
        struct Request {
            var url: String
        }
        struct Response {
            var url: String
        }
    }
    
    enum OpenWebView {
        struct Request {
            var url: URL
        }
        struct Response {
            var url: URL
        }
    }
    
    enum MarkArticle {
        struct Request {
            var url: String
            var indexPath: IndexPath
        }
        struct Response {
            var indexPath: IndexPath
            var removed: Bool
        }
        struct ViewModel {
            var indexPath: IndexPath
            var removed: Bool
        }
    }
    
    enum UpdateArticles {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
