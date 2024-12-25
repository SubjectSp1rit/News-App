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
    // MARK: - Constants
    private enum Constants {
        // closeButton
        static let closeButtonTitle: String = "Close"
        static let closeButtonBgColor: UIColor = .clear
        static let closeButtonTintColor: UIColor = .systemBlue
        static let closeButtonLeadingIndent: CGFloat = 10
        static let closeButtonTopIndent: CGFloat = 5
        static let closeButtonHeight: CGFloat = 30
        
        // webView
        static let webViewTopIndent: CGFloat = 5
    }
    
    private let closeButton: UIButton = UIButton(type: .system)
    
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
        configureBackground()
        configureCloseButton()
        configureWebView()
        loadURL()
    }
    
    // MARK: - Private Methods
    private func configureBackground() {
        // Размытие заднего фона
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.backgroundColor = Constants.closeButtonBgColor
        closeButton.tintColor = Constants.closeButtonTintColor
        closeButton.setTitle(Constants.closeButtonTitle, for: .normal)
        
        closeButton.pinLeft(to: view.leadingAnchor, Constants.closeButtonLeadingIndent)
        closeButton.pinTop(to: view.topAnchor, Constants.closeButtonTopIndent)
        closeButton.setHeight(Constants.closeButtonHeight)
        
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }
    
    private func configureWebView() {
        webView = WKWebView()
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(webView)
        
        webView.pinRight(to: view.trailingAnchor)
        webView.pinLeft(to: view.leadingAnchor)
        webView.pinTop(to: closeButton.bottomAnchor, Constants.webViewTopIndent)
        webView.pinBottom(to: view.bottomAnchor)
    }
    
    private func loadURL() {
        let url = interactor.url
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    // MARK: - Actions
    @objc
    private func closeButtonPressed() {
        dismiss(animated: true)
    }
}
