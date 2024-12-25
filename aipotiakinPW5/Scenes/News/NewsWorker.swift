//
//  NewsWorker.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

import UIKit

final class NewsWorker {
    // MARK: - Constants
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Variables
    private var decoder: JSONDecoder = JSONDecoder()
    private var newsPage: NewsModels.NewsPage = NewsModels.NewsPage()
    
    // MARK: - Public Methods
    func fetchNews(page: Int, completion: @escaping ([NewsModels.ArticleModel]) -> Void) {
        guard let url = getUrl(4, page) else {
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
               var newsPage = try? decoder.decode(NewsModels.NewsPage.self, from: data)
            {
                newsPage.passTheRequestId()
                newsPage = newsPage
                completion(newsPage.news ?? [])
            } else {
                completion([]) // Возвращаем пустой массив, если декодирование не удалось
            }
        }.resume()
    }
    
    func fetchImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        // Проверяем, есть ли изображение в кэше
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage)
            return
        }
        
        // Если изображения нет в кэше, загружаем его
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString) // Сохраняем в кэш
                completion(image)
            } else {
                completion(nil) // Возвращаем nil в случае ошибки
            }
        }.resume()
    }
    
    // MARK: - Private Methods
    private func getUrl(_ rubric: Int, _ pageIndex: Int) -> URL? {
        let url: String = "https://news.myseldon.com/api/Section?rubricId=\(rubric)&pageSize=8&pageIndex=\(pageIndex)"
        return URL(string: url)
    }
}
