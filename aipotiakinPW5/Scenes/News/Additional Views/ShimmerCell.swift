//
//  ShimmerCell.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 24.12.2024.
//

import Foundation
import UIKit

class ShimmerCell: UITableViewCell {
    // MARK: - Constants
    private let shimmerView = ShimmerView()
    static let reuseId: String = "ShimmerCell"

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupShimmerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShimmerView()
    }
    
    // MARK: - Public Methods
    func startShimmer() {
        shimmerView.startAnimating()
    }

    func stopShimmer() {
        shimmerView.stopAnimating()
    }
    
    // MARK: - Private Methods
    private func setupShimmerView() {
        contentView.addSubview(shimmerView)
        
        shimmerView.pin(to: contentView)
        shimmerView.pinHeight(to: contentView.widthAnchor)
    }
}
