//
//  WebNewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class WebNewsInteractor: WebNewsBusinessLogic {
    // MARK: - Constants
    private let presenter: WebNewsPresentationLogic
    
    // MARK: - Lifecycle
    init(presenter: WebNewsPresentationLogic) {
        self.presenter = presenter
    }
}
