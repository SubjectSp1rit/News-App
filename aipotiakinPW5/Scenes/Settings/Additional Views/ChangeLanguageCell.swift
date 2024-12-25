//
//  ShimmerCell.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 24.12.2024.
//

import Foundation
import UIKit

class ChangeLanguageCell: UITableViewCell {
    // MARK: - Constants
    static let reuseId: String = "ChangeLanguageCell"
    
    private enum Constants {
        // cell
        static let cellBgColor: UIColor = .clear
        
        // wrap
        static let wrapBgColor: UIColor = .systemGreen.withAlphaComponent(0.7)
        static let wrapCornerRadius: CGFloat = 15
        
        // changeLanguageLabel
        static let changeLanguageLabelTextAlignment: NSTextAlignment = .left
        static let changeLanguageLabelTextColor: UIColor = .white
        static let changeLanguageLabelLeadingIndent: CGFloat = 10
        static let changeLanguageLabelTopIndent: CGFloat = 15
        static let changeLanguageLabelBottomIndent: CGFloat = 15
        static let changeLanguageLabelText: String = "changeLanguageLabelText".localized
        
        // arrowImage
        static let arrowImageName: String = "arrow.forward"
        static let arrowImageTintColor: UIColor = .white
        
        // currentLanguageLabel
        static let currentLanguageLabelTextAlignment: NSTextAlignment = .right
        static let currentLanguageLabelTextColor: UIColor = .white
        
        // currentLanguageStack
        static let currentLanguageStackSpacingValue: CGFloat = 5
        static let currentLanguageStackTrailingIndent: CGFloat = 10
        static let currentLanguageStackTopIndent: CGFloat = 15
        static let currentLanguageStackBottomIndent: CGFloat = 15
    }
    
    // MARK: - UI Components
    let wrap: UIView = UIView()
    let changeLanguageLabel: UILabel = UILabel()
    let currentLanguageLabel: UILabel = UILabel()
    let arrowImage: UIImageView = UIImageView()
    let currentLanguageStack: UIStackView = UIStackView()

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
        configureCell()
        configureWrap()
        configureChangeLanguageLabel()
        configureCurrentLanguageStack()
    }
    
    private func configureCell() {
        backgroundColor = Constants.cellBgColor
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapBgColor
        wrap.layer.cornerRadius = Constants.wrapCornerRadius
        
        wrap.pin(to: contentView)
    }
    
    private func configureChangeLanguageLabel() {
        wrap.addSubview(changeLanguageLabel)
        
        changeLanguageLabel.textAlignment = Constants.changeLanguageLabelTextAlignment
        changeLanguageLabel.textColor = Constants.changeLanguageLabelTextColor
        changeLanguageLabel.text = Constants.changeLanguageLabelText
        
        changeLanguageLabel.pinLeft(to: wrap.leadingAnchor, Constants.changeLanguageLabelLeadingIndent)
        changeLanguageLabel.pinTop(to: wrap.topAnchor, Constants.changeLanguageLabelTopIndent)
        changeLanguageLabel.pinBottom(to: wrap.bottomAnchor, Constants.changeLanguageLabelBottomIndent)
    }
    
    private func configureCurrentLanguageStack() {
        configureCurrentLanguageLabel()
        configureArrowImage()
        
        currentLanguageStack.addArrangedSubview(currentLanguageLabel)
        currentLanguageStack.addArrangedSubview(arrowImage)
        currentLanguageStack.axis = .horizontal
        currentLanguageStack.spacing = Constants.currentLanguageStackSpacingValue
        currentLanguageStack.alignment = .trailing
        
        wrap.addSubview(currentLanguageStack)
        
        currentLanguageStack.pinRight(to: wrap.trailingAnchor, Constants.currentLanguageStackTrailingIndent)
        currentLanguageStack.pinTop(to: wrap.topAnchor, Constants.currentLanguageStackTopIndent)
        currentLanguageStack.pinBottom(to: wrap.bottomAnchor, Constants.currentLanguageStackBottomIndent)
    }
    
    private func configureCurrentLanguageLabel() {
        currentLanguageLabel.textAlignment = Constants.currentLanguageLabelTextAlignment
        currentLanguageLabel.textColor = Constants.currentLanguageLabelTextColor
        currentLanguageLabel.text = LanguageManager.shared.currentLanguage == "en" ? "English" : "Русский"
    }
    
    private func configureArrowImage() {
        arrowImage.image = UIImage(systemName: Constants.arrowImageName)
        arrowImage.contentMode = .scaleAspectFit
        arrowImage.tintColor = Constants.arrowImageTintColor
    }
}
