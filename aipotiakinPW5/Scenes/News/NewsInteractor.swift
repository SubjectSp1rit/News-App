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
        articles = worker.fetchArticles()
        presenter.presentNews(.init(articles: articles))
    }
    
    func loadStart(_ request: Models.Start.Request) {
        presenter.presentStart(Models.Start.Response())
    }
    
    func loadOther(_ request: Models.Other.Request) {
        presenter.presentOther(Models.Other.Response())
    }
}
