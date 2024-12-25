//
//  WebNewsViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let bgImageName: String = "background"
        
        // navBar
        static let navBarTitle: String = "settingsNavBarTitle".localized
    }
    
    // MARK: - Variables
    private var interactor: SettingsBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: SettingsBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureBackground()
    }
    
    private func configureNavBar() {
        self.title = Constants.navBarTitle
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.bgImageName)!)
        
        // Размытие заднего фона
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
}
