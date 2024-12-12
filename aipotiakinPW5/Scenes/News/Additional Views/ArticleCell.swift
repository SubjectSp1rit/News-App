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
        static let contentViewBgColor: UIColor = .white.withAlphaComponent(0.2)
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
    private let wrap: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
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
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        self.backgroundColor = Constants.cellBgColor
        contentView.backgroundColor = Constants.contentViewBgColor
        configureWrap()
        configureDescriptionLabel()
        configureTitleLabel()
    }
    
    private func configureWrap() {
        contentView.addSubview(wrap)
        
        wrap.backgroundColor = Constants.wrapBgColor
        wrap.contentMode = .scaleAspectFit
        wrap.image = UIImage(named: "background") // hard code need to be fixed
        wrap.clipsToBounds = true
        wrap.layer.cornerRadius = Constants.wrapCornerRadius
        
        wrap.pin(to: contentView)
        wrap.pinHeight(to: contentView.widthAnchor)
    }
    
    private func configureDescriptionLabel() {
        wrap.addSubview(descriptionLabel)
        
        descriptionLabel.textAlignment = Constants.descriptionLabelTextAlignment
        descriptionLabel.textColor = Constants.descriptionLabelTextColor
        descriptionLabel.numberOfLines = Constants.descriptionLabelNumberOfLines
        descriptionLabel.pinCenterX(to: wrap.centerXAnchor)
        descriptionLabel.pinLeft(to: wrap.leadingAnchor, Constants.descriptionLabelLeadingIndent)
        descriptionLabel.pinBottom(to: wrap.bottomAnchor, Constants.descriptionLabelBottomIndent)
    }
    
    private func configureTitleLabel() {
        wrap.addSubview(titleLabel)
        
        titleLabel.textAlignment = Constants.titleLabelTextAlignment
        titleLabel.textColor = Constants.titleLabelTextColor
        titleLabel.numberOfLines = Constants.titleLabelNumberOfLines
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.pinCenterX(to: wrap.centerXAnchor)
        titleLabel.pinLeft(to: wrap.leadingAnchor, Constants.titleLabelLeadingIndent)
        titleLabel.pinBottom(to: descriptionLabel.topAnchor, Constants.titleLabelBottomIndent)
    }
}
