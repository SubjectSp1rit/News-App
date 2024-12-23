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
        static let loadFreshNewsButtonImageName: String = "arrow.trianglehead.2.clockwise"
        static let loadFreshNewsButtonTintColor: UIColor = .systemGreen
        
        // table
        static let tableNumberOfRowsInSection: Int = 1
        static let tableBgColor: UIColor = .clear
        static let tableSectionBottomIndent: CGFloat = 10
        static let tableLastSectionBottomIndent: CGFloat = 0
        static let tableFirstRowIndex: Int = 0
        static let tableFirstSectionIndex: Int = 0
    }
    
    // MARK: - Variables
    private var interactor: (NewsBusinessLogic & NewsDataStore)
    
    // MARK: - UI Components
    private let table: UITableView = UITableView(frame: .zero)
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private let loadFreshNewsButton: UIButton = UIButton(type: .system)
    
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
        refreshControl.endRefreshing()
        table.reloadData()
        table.scrollToRow(at: IndexPath(row: Constants.tableFirstRowIndex, section: Constants.tableFirstSectionIndex), at: .top, animated: true)
    }
    
    // MARK: - Private Methods
    private func configureUI() {
        configureBackground()
        configureRefreshControl()
        configureTable()
        configureNavBar()
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.bgImageName)!)
        
        // Размытие заднего фона
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
        table.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        
        table.pin(to: view)
        
        table.refreshControl = refreshControl
        table.delegate = self
        table.dataSource = self
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        
        loadFreshNews()
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = .systemGreen
        refreshControl.attributedTitle = NSAttributedString(string: "Загрузка свежих новостей...", attributes: [.foregroundColor: UIColor.systemGreen])
        refreshControl.addTarget(self, action: #selector(refreshControllerPulled), for: .valueChanged)
    }
    
    private func configureNavBar() {
        self.title = Constants.navBarTitle
        
        loadFreshNewsButton.setImage(UIImage(systemName: Constants.loadFreshNewsButtonImageName), for: .normal)
        //loadFreshNewsButton.style = .plain
        loadFreshNewsButton.tintColor = Constants.loadFreshNewsButtonTintColor
        loadFreshNewsButton.addTarget(self, action: #selector(loadFreshNewsButtonPressed), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: loadFreshNewsButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func loadFreshNews() {
        interactor.loadFreshNews(Models.FetchArticles.Request())
    }
    
    // MARK: - Objc Methods
    @objc func loadFreshNewsButtonPressed() {
        loadFreshNews()
        
        guard let button = navigationItem.rightBarButtonItem?.customView as? UIButton else { return }
        UIView.animate(withDuration: 0.35, animations: {
            button.transform = button.transform.rotated(by: .pi)
        }, completion: { _ in
            UIView.animate(withDuration: 0.35, animations: {
                button.transform = button.transform.rotated(by: -.pi)
            })
        })
    }
    
    @objc func refreshControllerPulled() {
        loadFreshNews()
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

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.articles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.tableNumberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        // У последней ячейки снизу нет отступа, у всех остальных 10
        let lastSectionIndex = interactor.articles.count - 1
        return section == lastSectionIndex ? Constants.tableLastSectionBottomIndent : Constants.tableSectionBottomIndent
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Вью-заглушка для отступа под каждой секцией
        let spacerView: UIView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: ArticleCell.reuseId,
                                             for: indexPath)
        cell.selectionStyle = .none
        guard let articleCell = cell as? ArticleCell else { return cell }
        
        let currentArticle = interactor.articles[indexPath.section]
        articleCell.configureText(with: currentArticle)
        
        if let url = currentArticle.img?.url {
            interactor.loadImage(Models.FetchImage.Request(url: url,
                                                           completion: { [weak tableView] image in
                DispatchQueue.main.async {
                    // При назначении картинки проверяем, не переиспользовалась ли ячейка
                    if let currentCell = tableView?.cellForRow(at: indexPath) as? ArticleCell {
                        currentCell.configureImage(with: image)
                    }
                }
            }))
        }

        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
