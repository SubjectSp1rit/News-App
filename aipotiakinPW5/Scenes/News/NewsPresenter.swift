//
//  NewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

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
    
    func routeTo() {
        view?.navigationController?.pushViewController(NewsAssembly.build(), animated: true)
    }
}
