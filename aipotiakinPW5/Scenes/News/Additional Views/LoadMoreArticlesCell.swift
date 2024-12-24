//
//  ShimmerCell.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 24.12.2024.
//

import Foundation
import UIKit

class LoadMoreArticlesCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        // cell
        static let cellBgColor: UIColor = .clear
        
        // loadMoreArticlesButton
        static let loadMoreArticlesButtonTitle: String = "More"
    }
    
    static let reuseId: String = "LoadMoreArticlesCell"
    
    private let loadMoreArticlesButton: UIButton = UIButton(type: .system)
    
    // MARK: - Variables
    var onLoadMoreArticlesButtonPressed: (() -> Void)?

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureLoadMoreArticlesButton()
    }
    
    private func configureBackground() {
        backgroundColor = Constants.cellBgColor
    }
    
    private func configureLoadMoreArticlesButton() {
        contentView.addSubview(loadMoreArticlesButton)
        
        loadMoreArticlesButton.setTitle(Constants.loadMoreArticlesButtonTitle, for: .normal)
        loadMoreArticlesButton.tintColor = .white
        loadMoreArticlesButton.backgroundColor = .systemGreen
        loadMoreArticlesButton.addTarget(self, action: #selector(loadMoreArticlesButtonPressed), for: .touchUpInside)
        
        loadMoreArticlesButton.pin(to: contentView)
    }
    
    // MARK: - Actions
    @objc
    private func loadMoreArticlesButtonPressed() {
        onLoadMoreArticlesButtonPressed?()
    }
}
