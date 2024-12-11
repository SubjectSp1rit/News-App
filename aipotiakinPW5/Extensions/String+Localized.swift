import UIKit

// Пример использования: let helloText = "hello".localized ("hello" - ключ)
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
