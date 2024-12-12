//
//  TabController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

import UIKit

final class TabController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let tabBarBackgroundColor: UIColor = .darkGray.withAlphaComponent(0.95)
        static let tabBarTintColor: UIColor = .systemGreen
        static let tabBarUnselectedTintColor: UIColor = .systemGray2
        static let firstGradientColor: CGColor = UIColor.lightGray.withAlphaComponent(0.95).cgColor
        static let secondGradientColor: CGColor = UIColor.clear.cgColor
        static let gradientLayerPosX: CGFloat = 0
        static let gradientLayerPosY: CGFloat = 0
        static let gradientLayerHeight: CGFloat = 2
        static let navBarBackgroundColor: UIColor = .darkGray.withAlphaComponent(0.95)
        static let navBarTitleColor: UIColor = .white
        
        // home view
        static let homeTitle: String = "News"
        static let homeImageName: String = "newspaper"
        
        // settings view
        static let settingsTitle: String = "Settings"
        static let settingsImageName: String = "gear"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
        configureUI()
    }
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let home = self.createNav(with: Constants.homeTitle, and: UIImage(systemName: Constants.homeImageName), vc: NewsAssembly.build())
        let settings = self.createNav(with: Constants.settingsTitle, and: UIImage(systemName: Constants.settingsImageName), vc: NewsAssembly.build())
        
        self.setViewControllers([home, settings], animated: true)
    }
    
    private func configureUI() {
        self.tabBar.backgroundColor = Constants.tabBarBackgroundColor
        self.tabBar.tintColor = Constants.tabBarTintColor
        self.tabBar.unselectedItemTintColor = Constants.tabBarUnselectedTintColor
        
        // Добавление грани нижней панели
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.firstGradientColor, Constants.secondGradientColor]
        let gradientLayerWidth: CGFloat = tabBar.frame.width
        gradientLayer.frame = CGRect(x: Constants.gradientLayerPosX, y: Constants.gradientLayerPosY, width: gradientLayerWidth, height: Constants.gradientLayerHeight)
        self.tabBar.layer.addSublayer(gradientLayer)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        // Настройка фона верхней панели
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Constants.navBarBackgroundColor
        appearance.titleTextAttributes = [.foregroundColor: Constants.navBarTitleColor]
        appearance.shadowColor = nil
        
        // Добавление грани верхней панели
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Constants.firstGradientColor, Constants.secondGradientColor]
        let gradientLayerPosY: CGFloat = nav.navigationBar.frame.height
        let gradientLayerWidth: CGFloat = tabBar.frame.width
        gradientLayer.frame = CGRect(x: Constants.gradientLayerPosX, y: gradientLayerPosY, width: gradientLayerWidth, height: Constants.gradientLayerHeight)
        nav.navigationBar.layer.addSublayer(gradientLayer)
        
        nav.navigationBar.standardAppearance = appearance
        nav.navigationBar.scrollEdgeAppearance = appearance
        nav.navigationBar.compactAppearance = appearance
        
        return nav
    }
}
