//
//  TabController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 12.12.2024.
//

import UIKit

class TabController: UITabBarController {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let tabBarBackgroundColor: UIColor = .darkGray
        static let tabBarTintColor: UIColor = .systemGreen
        static let tabBarUnselectedTintColor: UIColor = .systemGray2
        
        // home view
        static let homeTitle: String = "News"
        static let homeImageName: String = "newspaper"
        
        // settings view
        static let settingsTitle: String = "Setting"
        static let settingsImageName: String = "gear"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabs()
        configureUI()
    }
    
    // MARK: - Tab Setup
    private func setupTabs() {
        let home = self.createView(with: Constants.homeTitle, and: UIImage(systemName: Constants.homeImageName), vc: NewsAssembly.build())
        let settings = self.createView(with: Constants.settingsTitle, and: UIImage(systemName: Constants.settingsImageName), vc: NewsAssembly.build())
        
        self.setViewControllers([home, settings], animated: true)
    }
    
    private func configureUI() {
        self.tabBar.backgroundColor = Constants.tabBarBackgroundColor
        self.tabBar.tintColor = Constants.tabBarTintColor
        self.tabBar.unselectedItemTintColor = Constants.tabBarUnselectedTintColor
    }
    
    private func createView(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
