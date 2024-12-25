//
//  WebNewsAssembly.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import UIKit

enum WebNewsAssembly {
    static func build(with url: URL) -> UIViewController {
        let presenter = WebNewsPresenter()
        let interactor = WebNewsInteractor(presenter: presenter, url: url)
        let view = WebNewsViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
