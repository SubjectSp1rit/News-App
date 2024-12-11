//
//  ViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        
        let label = UILabel()
        view.addSubview(label)
        label.pinCenterX(to: view.centerXAnchor)
        label.pinCenterY(to: view.centerYAnchor)
        label.text = "hello".localized
        
        let languageButton = UIButton(type: .system)
        languageButton.setTitle("Change Language", for: .normal)
        languageButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        view.addSubview(languageButton)
        languageButton.pinCenterX(to: view.centerXAnchor)
        languageButton.pinTop(to: label.bottomAnchor, 10)
    }

    @objc func changeLanguage() {
        let alertController = UIAlertController(title: "Select Language", message: nil, preferredStyle: .actionSheet)

        alertController.addAction(UIAlertAction(title: "English", style: .default, handler: { _ in
            LanguageManager.shared.setLanguage("en")
        }))

        alertController.addAction(UIAlertAction(title: "Русский", style: .default, handler: { _ in
            LanguageManager.shared.setLanguage("ru")
        }))

        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

