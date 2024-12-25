//
//  NewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit


protocol NewsDataStore {
    var articles: [Models.ArticleModel] { get set }
    var markedArticles: [Models.ArticleModel] { get set }
}

protocol NewsBusinessLogic {
    func loadFreshNews(_ request: Models.FetchArticles.Request)
    func loadMoreNews(_ request: Models.FetchMoreArticles.Request)
    func loadImage(_ request: Models.FetchImage.Request)
    func presentShareSheet(_ request: Models.ShareSheet.Request)
    func configureMarkedArticle(_ request: Models.MarkArticle.Request)
    func openWebNewsView(_ request: Models.OpenWebView.Request)
    func updateArticles(_ request: Models.UpdateArticles.Request)
}

protocol NewsPresentationLogic {
    func presentNews(_ response: Models.FetchArticles.Response)
    func presentMoreNews(_ response: Models.FetchMoreArticles.Response)
    func presentImageToCell(_ response: Models.FetchImage.Response)
    func presentShareSheet(_ response: Models.ShareSheet.Response)
    func presentMarkedArticle(_ response: Models.MarkArticle.Response)
    func routeToWebNewsView(_ response: Models.OpenWebView.Response)
    func presentUpdatedArticles(_ response: Models.UpdateArticles.Response)
}
