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
        // UI
        static let bgImageName: String = "background"
        
        // navBar
        static let navBarTitle: String = "News"
        
        // loadFreshNewsButton
        static let loadFreshNewsButtonImageName: String = "arrow.trianglehead.counterclockwise.rotate.90"
        static let loadFreshNewsButtonTintColor: UIColor = .systemGreen
        
        // table
        static let tableNumberOfSections: Int = 1
        static let tableBgColor: UIColor = .clear
    }
    
    // MARK: - Variables
    private var interactor: (NewsBusinessLogic & NewsDataStore)
    
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
        
        configureUI()
    }
    
    // MARK: - Public Methods
    func displayFetchedArticles(_ viewModel: Models.FetchArticles.ViewModel) {
        table.reloadData()
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureTable()
        configureNavBar()
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.bgImageName)!)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.backgroundColor = Constants.tableBgColor
        table.backgroundView = nil
        table.separatorStyle = .none
        
        table.pin(to: view)
        
        table.delegate = self
        table.dataSource = self
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        
        loadFreshNews()
    }
    
    private func configureNavBar() {
        self.title = Constants.navBarTitle
        
        loadFreshNewsButton.image = UIImage(systemName: Constants.loadFreshNewsButtonImageName)
        loadFreshNewsButton.style = .plain
        loadFreshNewsButton.tintColor = Constants.loadFreshNewsButtonTintColor
        //addEventButton.target = target
        self.navigationItem.rightBarButtonItem = loadFreshNewsButton
    }
    
    private func loadFreshNews() {
        interactor.loadFreshNews(Models.FetchArticles.Request())
    }
    
    // MARK: - Objc Methods
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

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableNumberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: ArticleCell.reuseId,
                                             for: indexPath)
        guard let articleCell = cell as? ArticleCell else { return cell }
        
        let currentArticle = interactor.articles[indexPath.row]
        articleCell.configureText(with: currentArticle)
        
        if let url = currentArticle.img?.url {
            interactor.loadImage(for: url) { [weak tableView] image in
                DispatchQueue.main.async {
                    // При назначении картинки проверяем, не переиспользовалась ли ячейк
                    if let currentCell = tableView?.cellForRow(at: indexPath) as? ArticleCell {
                        currentCell.configureImage(with: image)
                    }
                }
            }
        }
        
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ячейка \(indexPath.row)")
    }
}
