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
        
        // backgroundImage
        static let backgroundImageCornerRadius: CGFloat = 15
        
        // wrap
        static let wrapImageBgColor: UIColor = .clear
        static let wrapImageCornerRadius: CGFloat = 15
        
        // textWrap
        static let textWrapCornerRadius: CGFloat = 15
        static let textWrapBgCorner: UIColor = .black.withAlphaComponent(0.5)
        
        // descriptionLabel
        static let descriptionLabelTextAlignment: NSTextAlignment = .left
        static let descriptionLabelTextColor: UIColor = .white
        static let descriptionLabelLeadingIndent: CGFloat = 10
        static let descriptionLabelBottomIndent: CGFloat = 10
        static let descriptionLabelNumberOfLines: Int = 4
        
        // titleLabel
        static let titleLabelTextAlignment: NSTextAlignment = .left
        static let titleLabelTextColor: UIColor = .systemGreen
        static let titleLabelTopIndent: CGFloat = 10
        static let titleLabelLeadingIndent: CGFloat = 10
        static let titleLabelBottomIndent: CGFloat = 10
        static let titleLabelNumberOfLines: Int = 2
        static let titleLabelFontSize: CGFloat = 18
        static let titleLabelFontWeight: Double = 2.0
        
        // shareButton
        static let shareButtonBgColor: UIColor = .clear
        static let shareButtonTintColor: UIColor = .white.withAlphaComponent(0.85)
        static let shareButtonImageName: String = "square.and.arrow.up"
        static let shareButtonTopIndent: CGFloat = 8
        static let shareButtonLeadingIndent: CGFloat = 8
        
        // bookmarkButton
        static let bookmarkButtonBgColor: UIColor = .clear
        static let bookmarkButtonTintColor: UIColor = .white.withAlphaComponent(0.85)
        static let bookmarkButtonImageName: String = "bookmark"
        static let bookmarkButtonTopIndent: CGFloat = 8
        static let bookmarkButtonTrailingIndent: CGFloat = 8
    }
    
    static let reuseId: String = "ArticleCell"
    
    // MARK: - UI Components
    private let wrapImage: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let textWrap: UIView = UIView()
    private let backgroundImage: UIImageView = UIImageView()
    private let bookmarkButton: UIButton = UIButton(type: .system)
    private let shareButton: UIButton = UIButton(type: .system)
    
    // MARK: - Variables
    var onShareButtonTapped: ((String?) -> Void)?
    
    private(set) var articleUrl: String?
    
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
        articleUrl = article.sourceLink
        
    }
    
    func configureImage(with image: UIImage?) {
        guard let img = image else { return }
        wrapImage.image = img
        backgroundImage.image = img
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        
        configureBackgroundImage()
        configureWrapImage()
        configureTextWrap()
        configureDescriptionLabel()
        configureTitleLabel()
        configureBookmarkButton()
        configureShareButton()
    }
    
    private func configureShareButton() {
        wrapImage.addSubview(shareButton)
        
        shareButton.backgroundColor = Constants.shareButtonBgColor
        shareButton.tintColor = Constants.shareButtonTintColor
        shareButton.setImage(UIImage(systemName: Constants.shareButtonImageName), for: .normal)
        
        shareButton.pinTop(to: wrapImage.topAnchor, Constants.shareButtonTopIndent)
        shareButton.pinLeft(to: wrapImage.leadingAnchor, Constants.shareButtonLeadingIndent)
        
        shareButton.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
    }
    
    private func configureBookmarkButton() {
        wrapImage.addSubview(bookmarkButton)
        
        bookmarkButton.backgroundColor = Constants.bookmarkButtonBgColor
        bookmarkButton.tintColor = Constants.bookmarkButtonTintColor
        bookmarkButton.setImage(UIImage(systemName: Constants.bookmarkButtonImageName), for: .normal)
        
        bookmarkButton.pinTop(to: wrapImage.topAnchor, Constants.bookmarkButtonTopIndent)
        bookmarkButton.pinRight(to: wrapImage.trailingAnchor, Constants.bookmarkButtonTrailingIndent)
    }
    
    private func configureTextWrap() {
        wrapImage.addSubview(textWrap)
        
        textWrap.backgroundColor = Constants.textWrapBgCorner
        textWrap.clipsToBounds = true
        textWrap.layer.cornerRadius = Constants.textWrapCornerRadius
        textWrap.pinCenterX(to: wrapImage.centerXAnchor)
        textWrap.pinWidth(to: wrapImage.widthAnchor)
        textWrap.pinBottom(to: wrapImage.bottomAnchor)
    }
    
    private func configureBackgroundImage() {
        contentView.addSubview(backgroundImage)
        
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.layer.cornerRadius = Constants.backgroundImageCornerRadius
        
        backgroundImage.pin(to: contentView)
        backgroundImage.pinHeight(to: contentView.widthAnchor)
        
        // Размытие картинки на фоне
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        backgroundImage.addSubview(blurView)
        blurView.pin(to: backgroundImage)
    }
    
    private func configureWrapImage() {
        contentView.addSubview(wrapImage)
        wrapImage.isUserInteractionEnabled = true
        
        wrapImage.backgroundColor = Constants.wrapImageBgColor
        wrapImage.contentMode = .scaleAspectFit
        wrapImage.clipsToBounds = true
        wrapImage.layer.cornerRadius = Constants.wrapImageCornerRadius
        
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
        titleLabel.font = UIFont.systemFont(ofSize: Constants.titleLabelFontSize, weight: UIFont.Weight(rawValue: Constants.titleLabelFontWeight))
        titleLabel.textColor = Constants.titleLabelTextColor
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.pinCenterX(to: textWrap.centerXAnchor)
        titleLabel.pinLeft(to: textWrap.leadingAnchor, Constants.titleLabelLeadingIndent)
        titleLabel.pinBottom(to: descriptionLabel.topAnchor, Constants.titleLabelBottomIndent)
        titleLabel.pinTop(to: textWrap.topAnchor, Constants.titleLabelTopIndent)
    }
    
    // MARK: - Actions
    @objc
    private func shareButtonPressed() {
        guard let url = articleUrl else { return }
        onShareButtonTapped?(url)
    }
}
