//
//  WebNewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class SavedNewsInteractor: SavedNewsBusinessLogic, SavedNewsDataStore {
    // MARK: - Variables
    internal var markedArticles: [Models.ArticleModel] = []
    
    // MARK: - Constants
    private let presenter: SavedNewsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: SavedNewsPresentationLogic) {
        self.presenter = presenter
    }
}
