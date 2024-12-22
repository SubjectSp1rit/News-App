//
//  NewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    // MARK: - Constants
    private let imageCache = NSCache<NSString, UIImage>()
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
    
    func loadImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        // Проверяем, есть ли изображение в кэше
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        // Если изображения нет в кэше, загружаем его
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString) // Сохраняем в кэш
                completion(image)
            } else {
                completion(nil) // Возвращаем nil в случае ошибки
            }
        }.resume()
    }
}
