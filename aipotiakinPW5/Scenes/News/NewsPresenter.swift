//
//  NewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit
import WebKit

final class NewsPresenter: NewsPresentationLogic {
    // MARK: - Variables
    weak var view: NewsViewController?
    
    // MARK: - Public Methods
    func presentNews(_ response: Models.FetchArticles.Response) {
        view?.displayFetchedArticles(Models.FetchArticles.ViewModel())
    }
    
    func presentImageToCell(_ response: Models.FetchImage.Response) {
        view?.displayImageInCell(Models.FetchImage.ViewModel(fetchedImage: response.fetchedImage, indexPath: response.indexPath))
    }
    
    func presentShareSheet(_ response: Models.ShareSheet.Response) {
        let activityVC = UIActivityViewController(activityItems: [response.url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view?.view
        view?.present(activityVC, animated: true)
    }
    
    func presentMarkedArticle(_ response: Models.MarkArticle.Response) {
        if response.removed {
            view?.displayMarkedArticleInCell(Models.MarkArticle.ViewModel(indexPath: response.indexPath, removed: true))
        } else {
            view?.displayMarkedArticleInCell(Models.MarkArticle.ViewModel(indexPath: response.indexPath, removed: false))
        }
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(NewsAssembly.build(), animated: true)
    }
}
