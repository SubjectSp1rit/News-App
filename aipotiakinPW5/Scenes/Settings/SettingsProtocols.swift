//
//  WebNewsProtocols.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit

protocol SettingsBusinessLogic {
    func openChangeLanguage(_ request: SettingsModels.ChangeLanguage.Request)
}

protocol SettingsPresentationLogic {
    func presentChangeLanguage(_ response: SettingsModels.ChangeLanguage.Response)
}
