//
//  NewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit


protocol NewsDataStore {
    var articles: [NewsModels.ArticleModel] { get set }
    var markedArticles: [NewsModels.ArticleModel] { get set }
}

protocol NewsBusinessLogic {
    func loadFreshNews(_ request: NewsModels.FetchArticles.Request)
    func loadMoreNews(_ request: NewsModels.FetchMoreArticles.Request)
    func loadImage(_ request: NewsModels.FetchImage.Request)
    func presentShareSheet(_ request: NewsModels.ShareSheet.Request)
    func configureMarkedArticle(_ request: NewsModels.MarkArticle.Request)
    func openWebNewsView(_ request: NewsModels.OpenWebView.Request)
    func updateArticles(_ request: NewsModels.UpdateArticles.Request)
}

protocol NewsPresentationLogic {
    func presentNews(_ response: NewsModels.FetchArticles.Response)
    func presentMoreNews(_ response: NewsModels.FetchMoreArticles.Response)
    func presentImageToCell(_ response: NewsModels.FetchImage.Response)
    func presentShareSheet(_ response: NewsModels.ShareSheet.Response)
    func presentMarkedArticle(_ response: NewsModels.MarkArticle.Response)
    func routeToWebNewsView(_ response: NewsModels.OpenWebView.Response)
    func presentUpdatedArticles(_ response: NewsModels.UpdateArticles.Response)
}
