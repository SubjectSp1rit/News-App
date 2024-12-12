//
//  NewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    // MARK: - Constants
    private let presenter: NewsPresentationLogic
    private let worker: NewsWorker = NewsWorker()
    
    // MARK: - Variables
    internal var articles: [Models.ArticleModel] = [] {
        didSet {
            presenter.presentNews(.init(articles: articles))
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func loadFreshNews(_ request: Models.FetchArticles.Request) {
        //articles = worker.fetchNews()
        let array = worker.fetchNews()
        print(array)
    }
}
