//
//  NewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

protocol NewsDataStore {
    var articles: [Models.ArticleModel] { get set }
}

protocol NewsBusinessLogic {
    func loadFreshNews(_ request: Models.FetchArticles.Request)
}

protocol NewsPresentationLogic {
    func presentNews(_ response: Models.FetchArticles.Response)
    
    func routeTo()
}
