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
            presenter.presentNews(Models.FetchArticles.Response(articles: articles))
        }
    }
    internal var markedArticles: [Models.ArticleModel] = []
    
    private var isLoading: Bool = false
    
    // MARK: - Lifecycle
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func loadFreshNews(_ request: Models.FetchArticles.Request) {
        // Если новости уже загружаются - ничего не делаем
        guard !isLoading else { return }
        isLoading = true
        // Передаем в воркер функцию, которая выполнится после того, как fetchNews отработает
        DispatchQueue.global().async {
            self.worker.fetchNews(completion: { articles in
                DispatchQueue.main.async {
                    self.articles = articles
                    self.isLoading = false
                }
            })
        }
    }
    
    func loadImage(_ request: Models.FetchImage.Request) {
        DispatchQueue.global().async {
            self.worker.fetchImage(for: request.url, completion: { fetchedImage in
                DispatchQueue.main.async {
                    guard let fetchedImage = fetchedImage else { return } // Проверяем что картинка пришла
                    self.presenter.presentImageToCell(Models.FetchImage.Response(fetchedImage: fetchedImage, indexPath: request.indexPath)) // Отправляем ответ презентеру
                }
            })
        }
    }
    
    func presentShareSheet(_ request: Models.ShareSheet.Request) {
        presenter.presentShareSheet(Models.ShareSheet.Response(url: request.url))
    }
    
    func configureMarkedArticle(_ request: Models.MarkArticle.Request) {
        guard let markedArticle = articles.first(where: { $0.sourceLink == request.url }) else { return }
        
        // Если новость уже есть в списке - значит ее надо удалить
        if markedArticles.contains(where: { $0.sourceLink == request.url }) {
            markedArticles.removeAll(where: { $0.sourceLink == request.url })
            presenter.presentMarkedArticle(Models.MarkArticle.Response(indexPath: request.indexPath, removed: true))
        } else { // Иначе добавить в массив
            markedArticles.append(markedArticle)
            presenter.presentMarkedArticle(Models.MarkArticle.Response(indexPath: request.indexPath, removed: false))
        }
    }
}
