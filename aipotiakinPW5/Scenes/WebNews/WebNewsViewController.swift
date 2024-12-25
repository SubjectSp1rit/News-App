//
//  WebNewsViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class WebNewsViewController: UIViewController {
    // MARK: - Variables
    private var interactor: WebNewsBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: WebNewsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
