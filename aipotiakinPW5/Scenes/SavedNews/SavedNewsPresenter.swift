//
//  WebNewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class SavedNewsPresenter: SavedNewsPresentationLogic {
    // MARK: - Variables
    weak var view: SavedNewsViewController?
    
    // MARK: - Public Methods
    func presentFetchedArticles(_ response: SavedNewsModels.FetchArticles.Response) {
        view?.displayFetchedArticles(SavedNewsModels.FetchArticles.ViewModel())
    }
    
    func presentImageToCell(_ response: SavedNewsModels.FetchImage.Response) {
        view?.displayImageInCell(SavedNewsModels.FetchImage.ViewModel(url: response.url, fetchedImage: response.fetchedImage, indexPath: response.indexPath))
    }
    
    func presentShareSheet(_ response: SavedNewsModels.ShareSheet.Response) {
        let activityVC = UIActivityViewController(activityItems: [response.url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = view?.view
        view?.present(activityVC, animated: true)
    }
    
    func routeToWebNewsView(_ response: SavedNewsModels.OpenWebView.Response) {
        let webVC = WebNewsAssembly.build(with: response.url)
        
        view?.present(webVC, animated: true)
    }
    
    func presentMarkedArticle(_ response: SavedNewsModels.MarkArticle.Response) {
        if response.removed {
            view?.displayMarkedArticleInCell(SavedNewsModels.MarkArticle.ViewModel(indexPath: response.indexPath, removed: true))
        } else {
            view?.displayMarkedArticleInCell(SavedNewsModels.MarkArticle.ViewModel(indexPath: response.indexPath, removed: false))
        }
    }
}
