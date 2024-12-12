//
//  NewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {
    weak var view: NewsViewController?
    
    func presentNews(_ response: Models.FetchArticles.Response) {
        view?.displayFetchedArticles(Models.FetchArticles.ViewModel(articles: response.articles))
    }
    
    func presentStart(_ response: Models.Start.Response) {
        view?.displayStart()
    }
    
    func presentOther(_ responde: Models.Other.Response) {
        view?.displayOther()
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(NewsAssembly.build(), animated: true)
    }
}
