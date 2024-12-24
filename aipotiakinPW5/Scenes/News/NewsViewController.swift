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
        static let tableFirstRowIndex: Int = 0
        static let tableFirstSectionIndex: Int = 0
        static let minimumTableNumberOfSections: Int = 8
        
        // leadingSwipeAction
        static let tableLeadingSwipeActionShareTitle: String = "Share"
        static let tableLeadingSwipeActionShareImageName: String = "square.and.arrow.up"
        static let tableLeadingSwipeActionShareBgColor: UIColor = .lightGray
        
        // trailingSwipeAction
        static let tableTrailingSwipeActionMarkTitle: String = "Mark"
        static let tableTrailingSwipeActionMarkImageName: String = "bookmark"
        static let tableTrailingSwipeActionMarkBgColor: UIColor = .systemYellow
    }
    
    // MARK: - Variables
    private var interactor: (NewsBusinessLogic & NewsDataStore)
    
    // MARK: - UI Components
    private let table: UITableView = UITableView(frame: .zero)
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    private let loadFreshNewsButton: UIButton = UIButton(type: .system)
    
    private var retryTimer: Timer?
    
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
        refreshControl.endRefreshing() // Новости загружены - завершаем прокрутку
        table.reloadData()
        
        if !interactor.articles.isEmpty { // Если новости загрузились - завершаем попытку загрузить новости
            retryTimer?.invalidate()
            retryTimer = nil
            
            scrollToTopIfNeeded() // Переносим пользователя к первой новости
        }
    }
    
    func displayImageInCell(_ viewModel: Models.FetchImage.ViewModel) {
        guard let articleCell = table.cellForRow(at: viewModel.indexPath) as? ArticleCell else { return }
        articleCell.configureImage(with: viewModel.fetchedImage)
    }
    
    func displayMarkedArticleInCell(_ viewModel: Models.MarkArticle.ViewModel) {
        guard let articleCell = table.cellForRow(at: viewModel.indexPath) as? ArticleCell else { return }
        if viewModel.removed { // Если удалили - красим в стандартный цвет
            articleCell.configureMark(for: false)
        } else { // Иначе красим в желтый
            articleCell.configureMark(for: true)
        }
    }
    
    // MARK: - Private Methods
    private func scrollToTopIfNeeded() {
        guard table.numberOfSections > 0, // Проверка, что есть хотя бы одна секция
              table.numberOfRows(inSection: 0) > 0 // Проверка, что в секции есть строки
        else {
            return
        }

        // Прокрутка к первой строке
        table.scrollToRow(at: IndexPath(row: Constants.tableFirstRowIndex, section: Constants.tableFirstSectionIndex), at: .top, animated: true)
    }
    
    private func configureUI() {
        configureBackground()
        configureRefreshControl()
        configureTable()
        configureNavBar()
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.bgImageName)!)
        
        // Размытие заднего фона
        let blurEffect = UIBlurEffect(style: .dark)
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
        
        table.refreshControl = refreshControl
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
        table.register(ShimmerCell.self, forCellReuseIdentifier: ShimmerCell.reuseId)
        table.register(LoadMoreArticlesCell.self, forCellReuseIdentifier: LoadMoreArticlesCell.reuseId)
        
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
        loadFreshNewsButton.tintColor = Constants.loadFreshNewsButtonTintColor
        loadFreshNewsButton.addTarget(self, action: #selector(loadFreshNewsButtonPressed), for: .touchUpInside)
        
        let rightBarButton = UIBarButtonItem(customView: loadFreshNewsButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func loadFreshNews() {
        interactor.loadFreshNews(Models.FetchArticles.Request())
        
        // Запускаем повторную попытку загрузки новостей через секунду на повторе
        retryTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            self.interactor.loadFreshNews(Models.FetchArticles.Request())
        })
    }
    
    private func loadMoreNews() {
        print("Load News Button Pressed")
    }
    
    // MARK: - Actions
    @objc func loadFreshNewsButtonPressed() {
        loadFreshNews()
        
        guard let button = navigationItem.rightBarButtonItem?.customView as? UIButton else { return }
        UIView.animate(withDuration: 0.35, animations: {
            button.transform = button.transform.rotated(by: .pi)
        }, completion: { _ in
            UIView.animate(withDuration: 0.35, animations: {
                button.transform = button.transform.rotated(by: .pi)
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
    private func handleBookmark(for indexPath: IndexPath) {
        guard let articleCell = table.cellForRow(at: indexPath) as? ArticleCell else { return }
        guard let url = articleCell.articleUrl else { return }
        interactor.configureMarkedArticle(Models.MarkArticle.Request(url: url, indexPath: indexPath))
    }
    
    private func handleShare(for indexPath: IndexPath) {
        guard let articleCell = table.cellForRow(at: indexPath) as? ArticleCell else { return }
        guard let url = articleCell.articleUrl else { return }
        interactor.presentShareSheet(Models.ShareSheet.Request(url: url))
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        let quantity = interactor.articles.count
        if quantity == 0 { // Если отображаем ячейки
            return Constants.minimumTableNumberOfSections
        }
        return interactor.articles.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.tableNumberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.tableSectionBottomIndent
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        // Вью-заглушка для отступа под каждой секцией
        let spacerView: UIView = UIView()
        spacerView.backgroundColor = .clear
        return spacerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if interactor.articles.isEmpty { // Если нет новостей - показываем заглушки
            let cell = table.dequeueReusableCell(withIdentifier: ShimmerCell.reuseId, for: indexPath)
            guard let shimmerCell = cell as? ShimmerCell else { return cell }
            shimmerCell.startShimmer()
            return shimmerCell
        }
        
        let loadMoreArticlesButtonIndex = interactor.articles.count
        if indexPath.section == loadMoreArticlesButtonIndex {
            let cell = table.dequeueReusableCell(withIdentifier: LoadMoreArticlesCell.reuseId,
                                                 for: indexPath)
            guard let loadMoreArticlesCell = cell as? LoadMoreArticlesCell else { return cell }
            
            loadMoreArticlesCell.onLoadMoreArticlesButtonPressed = { [weak self] in
                self?.loadMoreNews()
            }
            
            return loadMoreArticlesCell
        }
        
        let cell = table.dequeueReusableCell(withIdentifier: ArticleCell.reuseId,
                                             for: indexPath)
        cell.selectionStyle = .none
        guard let articleCell = cell as? ArticleCell else { return cell }
        
        let currentArticle = interactor.articles[indexPath.section]
        articleCell.configure(with: currentArticle)
        articleCell.resetImages()
        
        if (interactor.markedArticles.contains(where: { $0.sourceLink == currentArticle.sourceLink })) {
            articleCell.configureMark(for: true)
        } else {
            articleCell.configureMark(for: false)
        }
        
        articleCell.onShareButtonTapped = { [weak self] url in
            guard let url = url else { return }
            self?.interactor.presentShareSheet(Models.ShareSheet.Request(url: url))
        }
        
        articleCell.onBookmarkButtonTapped = { [weak self] url in
            guard let url = url else { return }
            self?.interactor.configureMarkedArticle(Models.MarkArticle.Request(url: url, indexPath: indexPath))
        }
        
        // Скачиваем картинку
        if let url = currentArticle.img?.url {
            interactor.loadImage(Models.FetchImage.Request(url: url, indexPath: indexPath))
        }

        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let shimmerCell = cell as? ShimmerCell { // Завершение мерцания
            shimmerCell.stopShimmer()
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let loadMoreArticlesButtonSectionIndex = interactor.articles.count
        if indexPath.section == loadMoreArticlesButtonSectionIndex { return nil }
        if interactor.articles.isEmpty { return nil }
        
        let action = UIContextualAction(style: .normal,
                                        title: Constants.tableLeadingSwipeActionShareTitle) { [weak self] (_, _, completionHandler) in
            self?.handleShare(for: indexPath)
            completionHandler(true)
        }
        
        action.backgroundColor = Constants.tableLeadingSwipeActionShareBgColor
        action.image = UIImage(systemName: Constants.tableLeadingSwipeActionShareImageName)
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let loadMoreArticlesButtonSectionIndex = interactor.articles.count
        if indexPath.section == loadMoreArticlesButtonSectionIndex { return nil }
        if interactor.articles.isEmpty { return nil }
        
        let action = UIContextualAction(style: .normal,
                                        title: Constants.tableTrailingSwipeActionMarkTitle) { [weak self] (_, _, completionHandler) in
            self?.handleBookmark(for: indexPath)
            completionHandler(true)
        }
        
        action.backgroundColor = Constants.tableTrailingSwipeActionMarkBgColor
        action.image = UIImage(systemName: Constants.tableTrailingSwipeActionMarkImageName)
        
        let configuration = UISwipeActionsConfiguration(actions: [action])
        
        return configuration
    }
}
