//
//  NewsWorker.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

import UIKit

final class SavedNewsWorker {
    // MARK: - Constants
    private let imageCache = NSCache<NSString, UIImage>()
    
    // MARK: - Variables
    private var decoder: JSONDecoder = JSONDecoder()
    private var newsPage: NewsModels.NewsPage = NewsModels.NewsPage()
    
    // MARK: - Public Methods
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
}
