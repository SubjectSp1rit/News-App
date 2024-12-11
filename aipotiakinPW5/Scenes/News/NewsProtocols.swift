//
//  NewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

protocol NewsBusinessLogic {
    func loadStart(_ request: NewsModel.Start.Request)
    func loadOther(_ request: NewsModel.Other.Request)
}

protocol NewsPresentationLogic {
    func presentStart(_ response: NewsModel.Start.Response)
    func presentOther(_ response: NewsModel.Other.Response)
    
    func routeTo()
}
