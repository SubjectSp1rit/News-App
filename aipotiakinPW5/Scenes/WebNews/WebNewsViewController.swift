//
//  WebNewsViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit
import WebKit

final class WebNewsViewController: UIViewController {
    // MARK: - Variables
    private var interactor: (WebNewsBusinessLogic & WebNewsDataStore)
    private var webView: WKWebView!
    
    // MARK: - Lifecycle
    init(interactor: (WebNewsBusinessLogic & WebNewsDataStore)) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        loadURL()
    }
    
    // MARK: - Private Methods
    private func configureWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
    }
    
    private func loadURL() {
        let url = interactor.url
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
