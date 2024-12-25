//
//  UserDefaultsManager.swift
//  aipotiakinPW2
//
//  Created by Arseniy on 12/2/24.
//

import Foundation
import UIKit

// Singleton-class for managing UserDefaults
final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults: UserDefaults

    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    // MARK: - Generic Save and Load Methods
    
    func save<T: Codable>(_ wishes: [T], forKey key: String) {
        do {
            let data = try JSONEncoder().encode(wishes)
            defaults.set(data, forKey: key)
        } catch {
            fatalError("Error when saving to UserDefaults")
        }
    }
    
    func load<T: Codable>(forKey key: String) -> [T] {
        guard let data = defaults.data(forKey: key) else { return [] }
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            fatalError("Error when loading from UserDefaults")
        }
    }
}
