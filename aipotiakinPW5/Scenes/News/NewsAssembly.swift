//
//  NewsAssembly.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

enum NewsAssembly {
    static func build() -> UIViewController {
        let presenter = NewsPresenter()
        let interactor = NewsInteractor(presenter: presenter)
        let view = NewsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
