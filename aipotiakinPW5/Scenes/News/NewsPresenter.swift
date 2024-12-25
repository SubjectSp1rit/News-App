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
    func presentNews(_ response: NewsModels.FetchArticles.Response) {
        if response.pageIndex == 1 {
            view?.displayFetchedArticles(NewsModels.FetchArticles.ViewModel())
        } else {
            presentMoreNews(NewsModels.FetchMoreArticles.Response(pageIndex: response.pageIndex))
        }
    }
    
    func presentMoreNews(_ response: NewsModels.FetchMoreArticles.Response) {
        view?.displayMoreFetchedArticles(NewsModels.FetchMoreArticles.ViewModel(pageIndex: response.pageIndex))
    }
    
    func presentImageToCell(_ response: NewsModels.FetchImage.Response) {
        view?.displayImageInCell(NewsModels.FetchImage.ViewModel(url: response.url, fetchedImage: response.fetchedImage, indexPath: response.indexPath))
    }
    
    func presentShareSheet(_ response: NewsModels.ShareSheet.Response) {
        let activityVC = UIActivityViewController(activityItems: [response.url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view?.view
        view?.present(activityVC, animated: true)
    }
    
    func routeToWebNewsView(_ response: NewsModels.OpenWebView.Response) {
        let webVC = WebNewsAssembly.build(with: response.url)
        
        view?.present(webVC, animated: true)
    }
    
    func presentUpdatedArticles(_ response: NewsModels.UpdateArticles.Response) {
        view?.displayUpdatedArticles(NewsModels.UpdateArticles.ViewModel())
    }
    
    func presentMarkedArticle(_ response: NewsModels.MarkArticle.Response) {
        if response.removed {
            view?.displayMarkedArticleInCell(NewsModels.MarkArticle.ViewModel(indexPath: response.indexPath, removed: true))
        } else {
            view?.displayMarkedArticleInCell(NewsModels.MarkArticle.ViewModel(indexPath: response.indexPath, removed: false))
        }
    }
}
