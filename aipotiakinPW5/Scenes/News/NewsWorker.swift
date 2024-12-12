//
//  NewsWorker.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

final class NewsWorker {
    // MARK: - Public Methods
    func fetchArticles() -> [Models.ArticleModel] {
        return [Models.ArticleModel(title: "title", description: "description", imageName: "background", url: "1"), Models.ArticleModel(title: "2", description: "2", imageName: "background", url: "2"), Models.ArticleModel(title: "3", description: "3", imageName: "background", url: "3"), Models.ArticleModel(title: "4", description: "4", imageName: "background", url: "4")]
    }
    
    func fetchMoreArticles() -> [Models.ArticleModel] {
        return [Models.ArticleModel(title: "1", description: "1", imageName: "background", url: "1")]
    }
}
