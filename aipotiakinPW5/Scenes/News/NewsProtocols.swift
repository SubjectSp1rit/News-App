//
//  NewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

protocol NewsDataStore {
    var articles: [Models.ArticleModel] { get set }
}

protocol NewsBusinessLogic {
    func loadFreshNews(_ request: Models.FetchArticles.Request)
    func loadImage(_ request: Models.FetchImage.Request)
    
    func presentShareSheet(_ request: Models.ShareSheet.Request)
}

protocol NewsPresentationLogic {
    func presentNews(_ response: Models.FetchArticles.Response)
    func presentImageToCell(_ response: Models.FetchImage.Response)
    
    func presentShareSheet(_ response: Models.ShareSheet.Response)
    
    func routeTo()
}
