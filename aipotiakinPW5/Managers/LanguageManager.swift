import Foundation

final class LanguageManager {
    static let shared = LanguageManager()

    private let userDefaults = UserDefaults.standard
    private let appleLanguagesKey = "AppleLanguages"

    private init() {}

    /// Текущий язык
    var currentLanguage: String {
        guard let languages = userDefaults.array(forKey: appleLanguagesKey) as? [String] else {
            return Locale.current.language.languageCode?.identifier ?? "en"
        }
        return languages.first ?? "en"
    }

    /// Установка нового языка
    func setLanguage(_ languageCode: String) {
        userDefaults.set([languageCode], forKey: appleLanguagesKey)
        userDefaults.synchronize()
    }
}
