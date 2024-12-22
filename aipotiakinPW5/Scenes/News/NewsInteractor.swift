//
//  NewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    // MARK: - Constants
    private let presenter: NewsPresentationLogic
    private let worker: NewsWorker = NewsWorker()
    
    // MARK: - Variables
    internal var articles: [Models.ArticleModel] = [] {
        didSet {
            print(articles)
            presenter.presentNews(.init(articles: articles))
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func loadFreshNews(_ request: Models.FetchArticles.Request) {
        // Передаем в воркер функцию, которая выполнится после того, как fetchNews отработает
        DispatchQueue.global().async {
            self.worker.fetchNews(completion: { articles in
                DispatchQueue.main.async {
                    self.articles = articles
                }
            })
        }
    }
    
    func loadImage(_ request: Models.FetchImage.Request) {
        DispatchQueue.global().async {
            self.worker.fetchImage(for: request.url, completion: { image in
                DispatchQueue.main.async {
                    return request.completion(image)
                }
            })
        }
    }
}
