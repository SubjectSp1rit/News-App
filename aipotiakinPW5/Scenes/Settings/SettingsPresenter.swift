//
//  WebNewsPresenter.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class SettingsPresenter: SettingsPresentationLogic {
    // MARK: - Variables
    weak var view: SettingsViewController?
    
    // MARK: - Public Methods
    func presentChangeLanguage(_ response: SettingsModels.ChangeLanguage.Response) {
        let alertController = UIAlertController(title: "selectLanguage".localized, message: nil, preferredStyle: .actionSheet)

        // Русский язык
        alertController.addAction(UIAlertAction(title: "Русский", style: .default, handler: { _ in
            changeLanguage(to: "ru")
        }))

        // Английский язык
        alertController.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
            changeLanguage(to: "en")
        }))

        // Отмена
        alertController.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))

        view?.present(alertController, animated: true)
        
        func changeLanguage(to languageCode: String) {
            LanguageManager.shared.setLanguage(languageCode) { didChange in
                if didChange {
                    showRestartAlert()
                }
            }
        }
        
        func showRestartAlert() {
            let alert = UIAlertController(
                title: "restartAlertTitle".localized,
                message: "restartAlertMessage".localized,
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "ok".localized, style: .default))
            view?.present(alert, animated: true)
        }
    }
}
