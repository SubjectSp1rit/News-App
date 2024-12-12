//
//  NewsWorker.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

import UIKit

final class NewsWorker {
    // MARK: - Variables
    private var decoder: JSONDecoder = JSONDecoder()
    private var newsPage: Models.NewsPage = Models.NewsPage()
    private var news: [Models.ArticleModel] = []
    
    // MARK: - Public Methods
    private func getUrl(_ rubric: Int, _ pageIndex: Int) -> URL? {
        let url: String = "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)"
        print(url)
        return URL(string: url)
    }
    
    func fetchNews() {
        guard let url = getUrl(4, 1) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            if
               let data = data,
               var newsPage = try? self?.decoder.decode(Models.NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                self?.newsPage = newsPage
                self?.news = newsPage.news ?? []
            }
        }.resume()
    }
}
