//
//  NewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {
    // MARK: - Variables
    weak var view: NewsViewController?
    
    // MARK: - Public Methods
    func presentNews(_ response: Models.FetchArticles.Response) {
        view?.displayFetchedArticles(Models.FetchArticles.ViewModel())
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(NewsAssembly.build(), animated: true)
    }
}
