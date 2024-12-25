//
//  WebNewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class WebNewsInteractor: WebNewsBusinessLogic, WebNewsDataStore {
    // MARK: - Constants
    private let presenter: WebNewsPresentationLogic
    
    // MARK: - Variables
    internal var url: URL
    
    // MARK: - Lifecycle
    init(presenter: WebNewsPresentationLogic, url: URL) {
        self.presenter = presenter
        self.url = url
    }
    
    // MARK: - Public Methods
    func fetchWebContent() -> URL {
        return url
    }
}
