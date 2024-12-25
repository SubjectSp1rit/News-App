//
//  WebNewsViewController.swift
//  aipotiakinPW5
//
//  Created by Arseniy on 25.12.2024.
//

import Foundation
import UIKit
import WebKit

final class SavedNewsViewController: UIViewController {
    // MARK: - Constants
    private enum Constants {
        // UI
        static let bgImageName: String = "background"
        
        // navBar
        static let navBarTitle: String = "savedNewsNavBarTitle".localized
        
        // table
        static let tableNumberOfRowsInSection: Int = 1
        static let tableBgColor: UIColor = .clear
        static let tableSectionBottomIndent: CGFloat = 10
        static let tableLastSectionBottomIndent: CGFloat = 0
        static let tableFirstRowIndex: Int = 0
        static let tableFirstSectionIndex: Int = 0
        static let minimumTableNumberOfSections: Int = 8
        
        // leadingSwipeAction
        static let tableLeadingSwipeActionShareTitle: String = "swipeActionShareTitle".localized
        static let tableLeadingSwipeActionShareImageName: String = "square.and.arrow.up"
        static let tableLeadingSwipeActionShareBgColor: UIColor = .lightGray
        
        // trailingSwipeAction
        static let tableTrailingSwipeActionMarkTitle: String = "swipeActionMarkTitle".localized
        static let tableTrailingSwipeActionMarkImageName: String = "bookmark"
        static let tableTrailingSwipeActionMarkBgColor: UIColor = .systemYellow
    }
    
    // MARK: - UI Components
    private let table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Variables
    private var interactor: (SavedNewsBusinessLogic & SavedNewsDataStore)
    
    // MARK: - Lifecycle
    init(interactor: (SavedNewsBusinessLogic & SavedNewsDataStore)) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadSavedNews()
    }
    
    // MARK: - Public Methods
    func displayFetchedArticles(_ viewModel: SavedNewsModels.FetchArticles.ViewModel) {
        table.reloadData()
    }
    
    func displayImageInCell(_ viewModel: SavedNewsModels.FetchImage.ViewModel) {
        guard let articleCell = table.cellForRow(at: viewModel.indexPath) as? ArticleCell else { return }
        let imgUrlFromCell = articleCell.imgUrl
        let imgUrlFromPresenter = viewModel.url.absoluteString
        guard imgUrlFromCell == imgUrlFromPresenter else { return } // Проверка что ячейка имеет тот же url картинки
        articleCell.configureImage(with: viewModel.fetchedImage)
    }
    
    func displayMarkedArticleInCell(_ viewModel: SavedNewsModels.MarkArticle.ViewModel) {
        guard let articleCell = table.cellForRow(at: viewModel.indexPath) as? ArticleCell else { return }
        if viewModel.removed { // Если удалили - красим в стандартный цвет
            articleCell.configureMark(for: false)
        } else { // Иначе красим в желтый
            articleCell.configureMark(for: true)
        }
        table.reloadData()
    }
    
    // MARK: - Private Methods
    private func loadSavedNews() {
        interactor.fetchArticles(SavedNewsModels.FetchArticles.Request())
    }
    
    private func configureUI() {
        configureNavBar()
        configureBackground()
        configureTable()
    }
    
    private func configureTable() {
        view.addSubview(table)
        
        table.backgroundColor = Constants.tableBgColor
        table.backgroundView = nil
        table.separatorStyle = .none
        
        table.pin(to: view)
        
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.reuseId)
    }
    
    private func configureNavBar() {
        self.title = Constants.navBarTitle
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: Constants.bgImageName)!)
        
        // Размытие заднего фона
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        view.addSubview(blurEffectView)
        
        blurEffectView.pin(to: view)
    }
}

// MARK: - UITableViewDelegate
extension SavedNewsViewController: UITableViewDelegate {
    private func handleBookmark(for indexPath: IndexPath) {
        guard let articleCell = table.cellForRow(at: indexPath) as? ArticleCell else { return }
        guard let url = articleCell.articleUrl else { return }
        interactor.configureMarkedArticle(SavedNewsModels.MarkArticle.Request(url: url, indexPath: indexPath))
    }
    
    private func handleShare(for indexPath: IndexPath) {
        guard let articleCell = table.cellForRow(at: indexPath) as? ArticleCell else { return }
        guard let url = articleCell.articleUrl else { return }
        interactor.presentShareSheet(SavedNewsModels.ShareSheet.Request(url: url))
    }
}

// MARK: - UITableViewDataSource
extension SavedNewsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return interactor.markedArticles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.tableNumberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let lastSectionIndex = interactor.markedArticles.count - 1
        if lastSectionIndex == section && !interactor.markedArticles.isEmpty {
            return Constants.tableLastSectionBottomIndent
        }
        return Constants.tableSectionBottomIndent
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
        
        let currentArticle = interactor.markedArticles[indexPath.section]
        articleCell.configure(with: currentArticle)
        articleCell.setShimmerImage()
        
        if (interactor.markedArticles.contains(where: { $0.sourceLink == currentArticle.sourceLink })) {
            articleCell.configureMark(for: true)
        } else {
            articleCell.configureMark(for: false)
        }
        
        articleCell.onShareButtonTapped = { [weak self] url in
            guard let url = url else { return }
            self?.interactor.presentShareSheet(SavedNewsModels.ShareSheet.Request(url: url))
        }
        
        articleCell.onBookmarkButtonTapped = { [weak self] url in
            guard let url = url else { return }
            self?.interactor.configureMarkedArticle(SavedNewsModels.MarkArticle.Request(url: url, indexPath: indexPath))
        }
        
        // Скачиваем картинку
        if let url = currentArticle.img?.url {
            interactor.loadImage(SavedNewsModels.FetchImage.Request(url: url, indexPath: indexPath))
        }

        return articleCell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if interactor.markedArticles.isEmpty { return nil }
        
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
        if interactor.markedArticles.isEmpty { return nil }
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articleCell = table.cellForRow(at: indexPath) as? ArticleCell else { return }
        guard let urlString = articleCell.articleUrl else { return }
        guard let url = URL(string: urlString) else { return }
        
        interactor.openWebNewsView(SavedNewsModels.OpenWebView.Request(url: url))
    }
}

