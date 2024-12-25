//
//  WebNewsInteractor.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class SettingsInteractor: SettingsBusinessLogic {
    // MARK: - Constants
    private let presenter: SettingsPresentationLogic

    // MARK: - Lifecycle
    init(presenter: SettingsPresentationLogic) {
        self.presenter = presenter
    }
}
