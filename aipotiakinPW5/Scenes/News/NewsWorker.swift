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
    
    // MARK: - Public Methods
    private func getUrl(_ rubric: Int, _ pageIndex: Int) -> URL? {
        let url: String = "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)"
        return URL(string: url)
    }
    
    func fetchNews(completion: @escaping ([Models.ArticleModel]) -> Void) {
        guard let url = getUrl(4, 1) else {
                completion([]) // Возвращаем пустой массив, если URL невалиден
                return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                print(error)
                completion([]) // Возвращаем пустой массив в случае ошибки
                return
            }
            
            if
               let self = self,
               let data = data,
               var newsPage = try? decoder.decode(Models.NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                newsPage = newsPage
                completion(newsPage.news ?? [])
            } else {
                completion([]) // Возвращаем пустой массив, если декодирование не удалось
            }
        }.resume()
    }
}
