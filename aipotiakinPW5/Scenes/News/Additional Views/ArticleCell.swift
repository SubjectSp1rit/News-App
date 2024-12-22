//
//  ArticleCell.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

import UIKit

final class ArticleCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let contentViewBgColor: UIColor = .clear
        static let cellBgColor: UIColor = .clear
        
        // wrap
        static let wrapBgColor: UIColor = .clear
        static let wrapCornerRadius: CGFloat = 15
        
        // descriptionLabel
        static let descriptionLabelTextAlignment: NSTextAlignment = .left
        static let descriptionLabelTextColor: UIColor = .white
        static let descriptionLabelLeadingIndent: CGFloat = 10
        static let descriptionLabelBottomIndent: CGFloat = 10
        static let descriptionLabelNumberOfLines: Int = 4
        
        // titleLabel
        static let titleLabelTextAlignment: NSTextAlignment = .left
        static let titleLabelTextColor: UIColor = .systemGreen
        static let titleLabelLeadingIndent: CGFloat = 10
        static let titleLabelBottomIndent: CGFloat = 10
        static let titleLabelNumberOfLines: Int = 2
    }
    
    static let reuseId: String = "ArticleCell"
    
    // MARK: - UI Components
    private let wrapImage: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let textWrap: UIView = UIView()
    private let backgroundImage: UIImageView = UIImageView()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configureText(with article: Models.ArticleModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.announce
    }
    
    func configureImage(with image: UIImage?) {
        guard let img = image else { return }
        wrapImage.image = img
        backgroundImage.image = img
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        self.backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        configureBackgroundImage()
        configureWrapImage()
        configureTextWrap()
        configureDescriptionLabel()
        configureTitleLabel()
    }
    
    private func configureTextWrap() {
        wrapImage.addSubview(textWrap)
        
        textWrap.backgroundColor = .black.withAlphaComponent(0.5)
        textWrap.clipsToBounds = true
        textWrap.layer.cornerRadius = 15
        textWrap.pinCenterX(to: wrapImage.centerXAnchor)
        textWrap.pinWidth(to: wrapImage.widthAnchor)
        textWrap.pinBottom(to: wrapImage.bottomAnchor)
    }
    
    private func configureBackgroundImage() {
        contentView.addSubview(backgroundImage)
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = Constants.wrapCornerRadius
        
        backgroundImage.pin(to: contentView)
        backgroundImage.pinHeight(to: contentView.widthAnchor)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        backgroundImage.addSubview(blurView)
        blurView.pin(to: backgroundImage)
    }
    
    private func configureWrapImage() {
        contentView.addSubview(wrapImage)
        
        wrapImage.backgroundColor = Constants.wrapBgColor
        wrapImage.contentMode = .scaleAspectFit
        wrapImage.clipsToBounds = true
        wrapImage.layer.cornerRadius = Constants.wrapCornerRadius
        
        wrapImage.pin(to: contentView)
        wrapImage.pinHeight(to: contentView.widthAnchor)
    }
    
    private func configureDescriptionLabel() {
        textWrap.addSubview(descriptionLabel)
        
        descriptionLabel.textAlignment = Constants.descriptionLabelTextAlignment
        descriptionLabel.textColor = Constants.descriptionLabelTextColor
        descriptionLabel.numberOfLines = Constants.descriptionLabelNumberOfLines
        descriptionLabel.pinCenterX(to: textWrap.centerXAnchor)
        descriptionLabel.pinLeft(to: textWrap.leadingAnchor, Constants.descriptionLabelLeadingIndent)
        descriptionLabel.pinBottom(to: textWrap.bottomAnchor, Constants.descriptionLabelBottomIndent)
    }
    
    private func configureTitleLabel() {
        textWrap.addSubview(titleLabel)
        
        titleLabel.textAlignment = Constants.titleLabelTextAlignment
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(rawValue: 2.0))
        titleLabel.textColor = Constants.titleLabelTextColor
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.pinCenterX(to: textWrap.centerXAnchor)
        titleLabel.pinLeft(to: textWrap.leadingAnchor, Constants.titleLabelLeadingIndent)
        titleLabel.pinBottom(to: descriptionLabel.topAnchor, Constants.titleLabelBottomIndent)
        titleLabel.pinTop(to: textWrap.topAnchor, 10)
    }
}
