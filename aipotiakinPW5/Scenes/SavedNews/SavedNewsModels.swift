//
//  WebNewsModels.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

enum SavedNewsModels {
    enum FetchArticles {
        struct Request { }
        struct Response { }
        struct ViewModel { }
    }
    
    enum ShareSheet {
        struct Request {
            var url: String
        }
        struct Response {
            var url: String
        }
    }
    
    enum OpenWebView {
        struct Request {
            var url: URL
        }
        struct Response {
            var url: URL
        }
    }
    
    enum FetchImage {
        struct Request {
            var url: URL
            var indexPath: IndexPath
        }
        struct Response {
            var url: URL
            var fetchedImage: UIImage
            var indexPath: IndexPath
        }
        struct ViewModel {
            var url: URL
            var fetchedImage: UIImage
            var indexPath: IndexPath
        }
    }
    
    enum MarkArticle {
        struct Request {
            var url: String
            var indexPath: IndexPath
        }
        struct Response {
            var indexPath: IndexPath
            var removed: Bool
        }
        struct ViewModel {
            var indexPath: IndexPath
            var removed: Bool
        }
    }
}
