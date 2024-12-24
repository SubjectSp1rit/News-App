//
//  ShimmerView.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 24.12.2024.
//

import Foundation
import UIKit

class ShimmerView: UIView {
    // MARK: - Constants
    private enum Constants {
        // colors
        static let gradientColorOne:  CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        static let gradientColorTwo: CGColor = UIColor(white: 0.75, alpha: 1.0).cgColor
        static let gradientColorThree: CGColor = UIColor(white: 0.85, alpha: 1.0).cgColor
        
        static let startValueOne: Double = 0.0
        static let startValueTwo: Double = 0.0
        static let startValueThree: Double = 0.25
        
        static let endValueOne: Double = 0.75
        static let endValueTwo: Double = 1.0
        static let endValueThree: Double = 1.0
        
        // keys
        static let CABasicsAnumationKeyPath: String = "locations"
        static let mainGradientLayerKey: String = "shimmerEffect"
        
        // animations
        static let shimmerAnimation: CFTimeInterval = 1
        static let shimmerAnimationsQuantity: Float = .infinity
        
        // coordinates
        static let startX: Double = -4.0
        static let startY: Double = -1.0
        
        static let endX: Double = 2.0
        static let endY: Double = 2.0
        
        static let gradienColorOneLocation: NSNumber = 0.0
        static let gradienColorTwoLocation: NSNumber = 0.5
        static let gradienColorThreeLocation: NSNumber = 1.0
    }
    
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func startAnimating() {
        let animation = CABasicAnimation(keyPath: Constants.CABasicsAnumationKeyPath)
        animation.fromValue = [Constants.startValueOne, Constants.startValueTwo, Constants.startValueThree]
        animation.toValue = [Constants.endValueOne, Constants.endValueTwo, Constants.endValueThree]
        animation.duration = Constants.shimmerAnimation
        animation.repeatCount = Constants.shimmerAnimationsQuantity
        gradientLayer.add(animation, forKey: Constants.mainGradientLayerKey)
    }

    func stopAnimating() {
        gradientLayer.removeAllAnimations()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: - Private Methods
    private func setupGradientLayer() {
        gradientLayer.startPoint = CGPoint(x: Constants.startX, y: Constants.startY)
        gradientLayer.endPoint = CGPoint(x: Constants.endX, y: Constants.endY)

        gradientLayer.colors = [
            Constants.gradientColorOne,
            Constants.gradientColorTwo,
            Constants.gradientColorThree
        ]
        gradientLayer.locations = [Constants.gradienColorOneLocation, Constants.gradienColorTwoLocation, Constants.gradienColorThreeLocation]
        layer.addSublayer(gradientLayer)
    }
}
