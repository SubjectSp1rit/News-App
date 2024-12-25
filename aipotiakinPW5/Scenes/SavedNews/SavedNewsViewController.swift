//
//  WebNewsViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit
import WebKit

final class SavedNewsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let bgImageName: String = "background"
        
        // navBar
        static let navBarTitle: String = "Saved News"
        
        // table
        static let tableNumberOfRowsInSection: Int = 1
        static let tableBgColor: UIColor = .clear
        static let tableSectionBottomIndent: CGFloat = 10
        static let tableLastSectionBottomIndent: CGFloat = 0
        static let tableFirstRowIndex: Int = 0
        static let tableFirstSectionIndex: Int = 0
        static let minimumTableNumberOfSections: Int = 8
        
        // leadingSwipeAction
        static let tableLeadingSwipeActionShareTitle: String = "Share"
        static let tableLeadingSwipeActionShareImageName: String = "square.and.arrow.up"
        static let tableLeadingSwipeActionShareBgColor: UIColor = .lightGray
        
        // trailingSwipeAction
        static let tableTrailingSwipeActionMarkTitle: String = "Mark"
        static let tableTrailingSwipeActionMarkImageName: String = "bookmark"
        static let tableTrailingSwipeActionMarkBgColor: UIColor = .systemYellow
    }
    
    // MARK: - UI Components
    private let table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Variables
    private var retryTimer: Timer?
    private var interactor: (SavedNewsBusinessLogic & SavedNewsDataStore)
    
    // MARK: - Lifecycle
    init(interactor: (SavedNewsBusinessLogic & SavedNewsDataStore)) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
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
