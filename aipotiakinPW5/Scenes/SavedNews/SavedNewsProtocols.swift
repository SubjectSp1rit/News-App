//
//  WebNewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

protocol SavedNewsDataStore {
    var markedArticles: [Models.ArticleModel] { get set }
}

protocol SavedNewsBusinessLogic {
    func fetchArticles(_ request: SavedNewsModels.FetchArticles.Request)
    func loadImage(_ request: SavedNewsModels.FetchImage.Request)
    func presentShareSheet(_ request: SavedNewsModels.ShareSheet.Request)
    func configureMarkedArticle(_ request: SavedNewsModels.MarkArticle.Request)
    func openWebNewsView(_ request: SavedNewsModels.OpenWebView.Request)
}

protocol SavedNewsPresentationLogic {
    func presentFetchedArticles(_ response: SavedNewsModels.FetchArticles.Response)
    func presentImageToCell(_ response: SavedNewsModels.FetchImage.Response)
    func presentShareSheet(_ response: SavedNewsModels.ShareSheet.Response)
    func presentMarkedArticle(_ response: SavedNewsModels.MarkArticle.Response)
    func routeToWebNewsView(_ response: SavedNewsModels.OpenWebView.Response)
}
