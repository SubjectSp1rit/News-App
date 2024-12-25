//
//  WebNewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class SavedNewsInteractor: SavedNewsBusinessLogic, SavedNewsDataStore {
    // MARK: - Constants
    private let presenter: SavedNewsPresentationLogic
    private let worker: NewsWorker = NewsWorker()
    
    private enum Constants {
        // UserDefaults
        static let savedArticlesKey: String = "SavedArticles"
    }
    
    // MARK: - Variables
    internal var markedArticles: [Models.ArticleModel] = [] {
        didSet {
            UserDefaultsManager.shared.save(markedArticles, forKey: Constants.savedArticlesKey)
        }
    }
    
    // MARK: - Lifecycle
    init(presenter: SavedNewsPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public methods
    func fetchArticles(_ request: SavedNewsModels.FetchArticles.Request) {
        markedArticles = UserDefaultsManager.shared.load(forKey: Constants.savedArticlesKey)
        presenter.presentFetchedArticles(SavedNewsModels.FetchArticles.Response())
    }
    
    func loadImage(_ request: SavedNewsModels.FetchImage.Request) {
        DispatchQueue.global().async {
            self.worker.fetchImage(for: request.url, completion: { fetchedImage in
                DispatchQueue.main.async {
                    guard let fetchedImage = fetchedImage else { return } // Проверяем что картинка пришла
                    self.presenter.presentImageToCell(SavedNewsModels.FetchImage.Response(url: request.url, fetchedImage: fetchedImage, indexPath: request.indexPath)) // Отправляем ответ презентеру
                }
            })
        }
    }
    
    func configureMarkedArticle(_ request: SavedNewsModels.MarkArticle.Request) {
        guard let markedArticle = markedArticles.first(where: { $0.sourceLink == request.url }) else { return }
        
        // Если новость уже есть в списке - значит ее надо удалить
        if markedArticles.contains(where: { $0.sourceLink == request.url }) {
            markedArticles.removeAll(where: { $0.sourceLink == request.url })
            presenter.presentMarkedArticle(SavedNewsModels.MarkArticle.Response(indexPath: request.indexPath, removed: true))
        } else { // Иначе добавить в массив
            markedArticles.append(markedArticle)
            presenter.presentMarkedArticle(SavedNewsModels.MarkArticle.Response(indexPath: request.indexPath, removed: false))
        }
    }
    
    func presentShareSheet(_ request: SavedNewsModels.ShareSheet.Request) {
        presenter.presentShareSheet(SavedNewsModels.ShareSheet.Response(url: request.url))
    }
    
    func openWebNewsView(_ request: SavedNewsModels.OpenWebView.Request) {
        presenter.routeToWebNewsView(SavedNewsModels.OpenWebView.Response(url: request.url))
    }
}
