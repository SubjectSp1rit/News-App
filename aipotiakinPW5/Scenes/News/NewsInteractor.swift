//
//  NewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

final class NewsInteractor: NewsBusinessLogic {
    private let presenter: NewsPresentationLogic
    
    init(presenter: NewsPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadStart(_ request: NewsModel.Start.Request) {
        presenter.presentStart(NewsModel.Start.Response())
    }
    
    func loadOther(_ request: NewsModel.Other.Request) {
        presenter.presentOther(NewsModel.Other.Response())
    }
}
