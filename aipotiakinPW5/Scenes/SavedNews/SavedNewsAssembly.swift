//
//  SavedNewsAssembly.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import UIKit

enum SavedNewsAssembly {
    static func build() -> UIViewController {
        let presenter = SavedNewsPresenter()
        let interactor = SavedNewsInteractor(presenter: presenter)
        let view = SavedNewsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
