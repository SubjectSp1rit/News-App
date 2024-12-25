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
    
    private enum Constants {
        // UserDefaults
        static let savedArticlesKey: String = "SavedArticles"
    }
    
    // MARK: - Variables
    internal var articles: [NewsModels.ArticleModel] = [] {
        didSet {
            presenter.presentNews(NewsModels.FetchArticles.Response(pageIndex: currentNewsPage))
        }
    }
    internal var markedArticles: [NewsModels.ArticleModel] = UserDefaultsManager.shared.load(forKey: Constants.savedArticlesKey) {
        didSet {
            UserDefaultsManager.shared.save(markedArticles, forKey: Constants.savedArticlesKey)
        }
    }
    
    private var currentNewsPage: Int = 1
    private var isLoading: Bool = false
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func loadFreshNews(_ request: NewsModels.FetchArticles.Request) {
        // Если новости уже загружаются - ничего не делаем
        guard !isLoading else { return }
        isLoading = true
        currentNewsPage = 1
        
        DispatchQueue.global().async {
            self.worker.fetchNews(page: self.currentNewsPage, completion: { articles in
                DispatchQueue.main.async {
                    self.articles = articles
                    self.isLoading = false
                }
            })
        }
    }
    
    func loadMoreNews(_ request: NewsModels.FetchMoreArticles.Request) {
        // Если новости уже загружаются - ничего не делаем
        guard !isLoading else { return }
        isLoading = true
        currentNewsPage += 1
        
        DispatchQueue.global().async {
            self.worker.fetchNews(page: self.currentNewsPage, completion: { articles in
                DispatchQueue.main.async {
                    self.articles.append(contentsOf: articles)
                    self.isLoading = false
                }
            })
        }
    }
    
    func loadImage(_ request: NewsModels.FetchImage.Request) {
        DispatchQueue.global().async {
            self.worker.fetchImage(for: request.url, completion: { fetchedImage in
                DispatchQueue.main.async {
                    guard let fetchedImage = fetchedImage else { return } // Проверяем что картинка пришла
                    self.presenter.presentImageToCell(NewsModels.FetchImage.Response(url: request.url, fetchedImage: fetchedImage, indexPath: request.indexPath)) // Отправляем ответ презентеру
                }
            })
        }
    }
    
    func presentShareSheet(_ request: NewsModels.ShareSheet.Request) {
        presenter.presentShareSheet(NewsModels.ShareSheet.Response(url: request.url))
    }
    
    func openWebNewsView(_ request: NewsModels.OpenWebView.Request) {
        presenter.routeToWebNewsView(NewsModels.OpenWebView.Response(url: request.url))
    }
    
    func updateArticles(_ request: NewsModels.UpdateArticles.Request) {
        markedArticles = UserDefaultsManager.shared.load(forKey: Constants.savedArticlesKey)
        presenter.presentUpdatedArticles(NewsModels.UpdateArticles.Response())
    }
    
    func configureMarkedArticle(_ request: NewsModels.MarkArticle.Request) {
        guard let markedArticle = articles.first(where: { $0.sourceLink == request.url }) else { return }
        
        // Если новость уже есть в списке - значит ее надо удалить
        if markedArticles.contains(where: { $0.sourceLink == request.url }) {
            markedArticles.removeAll(where: { $0.sourceLink == request.url })
            presenter.presentMarkedArticle(NewsModels.MarkArticle.Response(indexPath: request.indexPath, removed: true))
        } else { // Иначе добавить в массив
            markedArticles.append(markedArticle)
            presenter.presentMarkedArticle(NewsModels.MarkArticle.Response(indexPath: request.indexPath, removed: false))
        }
    }
}
