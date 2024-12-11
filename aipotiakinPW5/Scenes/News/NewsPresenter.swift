//
//  NewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsPresenter: NewsPresentationLogic {
    weak var view: NewsViewController?
    
    func presentStart(_ response: NewsModel.Start.Response) {
        view?.displayStart()
    }
    
    func presentOther(_ responde: NewsModel.Other.Response) {
        view?.displayOther()
    }
    
    func routeTo() {
        view?.navigationController?.pushViewController(NewsAssembly.build(), animated: true)
    }
}
