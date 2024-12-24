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
        static let backgroundImageCornerRadius: CGFloat = 0
        
        // wrap
        static let wrapImageBgColor: UIColor = .clear
        static let wrapImageCornerRadius: CGFloat = 0
        
        // textWrap
        static let textWrapCornerRadius: CGFloat = 0
        static let textWrapBgCorner: UIColor = .black.withAlphaComponent(0.5)
        
        // descriptionLabel
        static let descriptionLabelTextAlignment: NSTextAlignment = .left
        static let descriptionLabelTextColor: UIColor = .white
        static let descriptionLabelLeadingIndent: CGFloat = 10
        static let descriptionLabelBottomIndent: CGFloat = 10
        static let descriptionLabelNumberOfLines: Int = 4
        
        // timeToReadStack
        static let timeToReadStackSpacingValue: CGFloat = 6
        static let timeToReadStackLeadingIndent: CGFloat = 10
        static let timeToReadStackBottomIndent: CGFloat = 10
        
        // timeToReadLabel
        static let timeToReadLabelTextAlignment: NSTextAlignment = .left
        static let timeToReadLabelTextColor: UIColor = .lightGray
        static let timeToReadLabelLeadingIndent: CGFloat = 10
        static let timeToReadLabelBottomIndent: CGFloat = 10
        static let timeToReadLabelNumberOfLines: Int = 1
        
        // timeToReadImage
        static let timeToReadImageName: String = "clock"
        static let timeToReadImageTintColor: UIColor = .lightGray
        
        // dateStack
        static let dateStackSpacingValue: CGFloat = 6
        static let dateStackTrailingIndent: CGFloat = 10
        static let dateStackBottomIndent: CGFloat = 10
        
        // dateLabel
        static let dateLabelTextAlignment: NSTextAlignment = .left
        static let dateLabelTextColor: UIColor = .lightGray
        static let dateLabelTrailingIndent: CGFloat = 10
        static let dateLabelBottomIndent: CGFloat = 10
        static let dateLabelNumberOfLines: Int = 1
        
        // dateImage
        static let dateImageName: String = "calendar"
        static let dateImageTintColor: UIColor = .lightGray
        
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
        static let shareButtonTintColor: UIColor = .lightGray
        static let shareButtonImageName: String = "square.and.arrow.up"
        static let shareButtonTopIndent: CGFloat = 8
        static let shareButtonLeadingIndent: CGFloat = 8
        
        // bookmarkButton
        static let bookmarkButtonBgColor: UIColor = .clear
        static let bookmarkButtonTintColor: UIColor = .lightGray
        static let bookmarkButtonImageName: String = "bookmark"
        static let bookmarkButtonTopIndent: CGFloat = 8
        static let bookmarkButtonTrailingIndent: CGFloat = 8
        static let bookmarkButtonMarkedTintColor: UIColor = .systemYellow
        static let bookmarkButtonMarkedImageName: String = "bookmark.fill"
    }
    
    static let reuseId: String = "ArticleCell"
    
    // MARK: - UI Components
    private let wrapImage: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let timeToReadStack: UIStackView = UIStackView()
    private let timeToReadImage: UIImageView = UIImageView()
    private let timeToReadLabel: UILabel = UILabel()
    private let dateStack: UIStackView = UIStackView()
    private let dateImage: UIImageView = UIImageView()
    private let dateLabel: UILabel = UILabel()
    private let textWrap: UIView = UIView()
    private let backgroundImage: UIImageView = UIImageView()
    private let bookmarkButton: UIButton = UIButton(type: .system)
    private let shareButton: UIButton = UIButton(type: .system)
    
    // MARK: - Variables
    var onShareButtonTapped: ((String?) -> Void)?
    var onBookmarkButtonTapped: ((String?) -> Void)?
    
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
    func configure(with article: Models.ArticleModel) {
        titleLabel.text = article.title
        descriptionLabel.text = article.announce
        articleUrl = article.sourceLink
        timeToReadLabel.text = article.timeOfReading
        dateLabel.text = article.date?.convertDateFormat()
    }
    
    func configureImage(with image: UIImage?) {
        guard let image = image else { return }
        wrapImage.image = image
        backgroundImage.image = image
    }
    
    /// Перекрашивает "bookmark"
    /// Входные параметры: state - true, если нужно закрасить в желтый, иначе стандартный цвет
    func configureMark(for state: Bool) {
        if state { // Желтый цвет
            bookmarkButton.tintColor = Constants.bookmarkButtonMarkedTintColor
            bookmarkButton.setImage(UIImage(systemName: Constants.bookmarkButtonMarkedImageName), for: .normal)
        } else { // Обычный цвет
            bookmarkButton.tintColor = Constants.bookmarkButtonTintColor
            bookmarkButton.setImage(UIImage(systemName: Constants.bookmarkButtonImageName), for: .normal)
        }
    }
    
    func markArticle() {
        
    }
    
    func unmarkArticle() {
        
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        
        configureBackgroundImage()
        configureWrapImage()
        configureTextWrap()
        configureTimeToReadStack()
        configureDateStack()
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
        
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonPressed), for: .touchUpInside)
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
    
    private func configureTimeToReadStack() {
        configureTimeToReadImage()
        configureTimeToReadLabel()
        
        timeToReadStack.addArrangedSubview(timeToReadImage)
        timeToReadStack.addArrangedSubview(timeToReadLabel)
        timeToReadStack.axis = .horizontal
        timeToReadStack.spacing = Constants.timeToReadStackSpacingValue
        timeToReadStack.alignment = .leading
        
        textWrap.addSubview(timeToReadStack)
        
        timeToReadStack.pinLeft(to: textWrap.leadingAnchor, Constants.timeToReadStackLeadingIndent)
        timeToReadStack.pinBottom(to: textWrap.bottomAnchor, Constants.timeToReadStackBottomIndent)
    }
    
    private func configureTimeToReadImage() {
        timeToReadImage.image = UIImage(systemName: Constants.timeToReadImageName)
        timeToReadImage.contentMode = .scaleAspectFit
        timeToReadImage.tintColor = Constants.timeToReadImageTintColor
    }
    
    private func configureTimeToReadLabel() {
        timeToReadLabel.textAlignment = Constants.timeToReadLabelTextAlignment
        timeToReadLabel.textColor = Constants.timeToReadLabelTextColor
        timeToReadLabel.numberOfLines = Constants.timeToReadLabelNumberOfLines
    }
    
    private func configureDateStack() {
        configureDateImage()
        configureDateLabel()
        
        dateStack.addArrangedSubview(dateImage)
        dateStack.addArrangedSubview(dateLabel)
        dateStack.axis = .horizontal
        dateStack.spacing = Constants.dateStackSpacingValue
        dateStack.alignment = .trailing
        
        textWrap.addSubview(dateStack)
        
        dateStack.pinRight(to: textWrap.trailingAnchor, Constants.dateStackTrailingIndent)
        dateStack.pinBottom(to: textWrap.bottomAnchor, Constants.dateStackBottomIndent)
    }
    
    private func configureDateImage() {
        dateImage.image = UIImage(systemName: Constants.dateImageName)
        dateImage.contentMode = .scaleAspectFit
        dateImage.tintColor = Constants.dateImageTintColor
    }
    
    private func configureDateLabel() {
        dateLabel.textAlignment = Constants.dateLabelTextAlignment
        dateLabel.textColor = Constants.dateLabelTextColor
        dateLabel.numberOfLines = Constants.dateLabelNumberOfLines
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
        descriptionLabel.pinBottom(to: timeToReadLabel.topAnchor, Constants.descriptionLabelBottomIndent)
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
    
    @objc
    private func bookmarkButtonPressed() {
        guard let url = articleUrl else { return }
        onBookmarkButtonTapped?(url)
    }
}
