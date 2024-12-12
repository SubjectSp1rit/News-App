//
//  NewsModels.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

enum Models {
    struct ArticleModel {
        var title: String
        var description: String
        var url: String
    }
    
    enum FetchArticles {
        struct Request { }
        struct Response {
            var articles: [ArticleModel]
        }
        struct ViewModel {
            var articles: [ArticleModel]
        }
    }
    
    enum Start {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum Other {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
}
