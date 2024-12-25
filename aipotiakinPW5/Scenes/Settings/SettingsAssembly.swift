//
//  WebNewsAssembly.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import UIKit

enum SettingsAssembly {
    static func build() -> UIViewController {
        let presenter = SettingsPresenter()
        let interactor = SettingsInteractor(presenter: presenter)
        let view = SettingsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
