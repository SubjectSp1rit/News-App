import UIKit

class LanguageManager {
    static let shared = LanguageManager()
    
    private init() {}

    func setLanguage(_ language: String) {
        UserDefaultsManager.shared.setLanguage(language)
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.reloadRootViewController()
    }
    
    func getCurrentLanguage() -> [String] {
        return UserDefaultsManager.shared.loadLanguage()
    }
}
