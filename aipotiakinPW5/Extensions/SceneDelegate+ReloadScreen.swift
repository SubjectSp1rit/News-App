import UIKit

extension SceneDelegate {
    func reloadRootViewController() {
        guard let windowScene = (self.window?.windowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: NewsAssembly.build())
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
