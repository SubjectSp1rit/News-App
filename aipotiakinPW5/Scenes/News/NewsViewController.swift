//
//  ViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 11.12.2024.
//

import UIKit

final class NewsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        // loadFreshNewsButton
        static let loadFreshNewsButtonImageName: String = "arrow.trianglehead.counterclockwise.rotate.90"
        static let loadFreshNewsButtonTintColor: UIColor = .systemGreen
    }
    
    // MARK: - Variables
    private var interactor: (NewsBusinessLogic & NewsDataStore)?
    
    // MARK: - UI Components
    private let table: UITableView = UITableView(frame: .zero)
    private let loadFreshNewsButton: UIBarButtonItem = UIBarButtonItem()
    
    // MARK: - Lifecycle
    init(interactor: (NewsBusinessLogic & NewsDataStore)) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.loadFreshNews(Models.FetchArticles.Request())
        configureUI()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureTable()
        configureLoadFreshNewsButton()
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.backgroundColor = .clear
        table.backgroundView = nil
        table.separatorStyle = .none
        
        table.pin(to: view)
        
        //table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseID)
        //table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseID)
    }
    
    private func configureLoadFreshNewsButton() {
        loadFreshNewsButton.image = UIImage(systemName: Constants.loadFreshNewsButtonImageName)
        loadFreshNewsButton.style = .plain
        loadFreshNewsButton.tintColor = Constants.loadFreshNewsButtonTintColor
        //addEventButton.target = target
        self.navigationItem.rightBarButtonItem = loadFreshNewsButton
    }
    
    func displayFetchedArticles(_ viewModel: Models.FetchArticles.ViewModel) {
        table.reloadData()
    }
    
    func displayStart() {
        
    }
    
    func displayOther() {
        
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

extension NewsViewController: UITableViewDelegate {
    
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
