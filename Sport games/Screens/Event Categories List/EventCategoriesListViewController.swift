//
//  ViewController.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import UIKit

class EventCategoriesListViewController: UIViewController {
    let viewModel: EventCategoriesListViewModel
    
    private lazy var categoriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .mainBackgroud
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EventCategoryTableViewCell.self, forCellReuseIdentifier: "eventCategoryTableViewCell")
        return tableView
    }()

    init(viewModel: EventCategoriesListViewModel = EventCategoriesListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .navigationBar
        self.navigationItem.titleView = UIView.navTitleWithImageAndText(titleText: "Sport Games", imageName: "soccer_icon")
        viewModel.fetchCategories()
        setupConstraints()
        setupBinding()
    }
    
    private func setupConstraints() {
       view.addSubview(categoriesTableView)
        NSLayoutConstraint.activate([
            categoriesTableView.topAnchor.constraint(equalTo: view.topAnchor),
            categoriesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoriesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupBinding() {
        viewModel.categories.bind(to: self) {this, _ in
            this.categoriesTableView.reloadData()
        }
    }

}

extension EventCategoriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model?.categories.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCategoryTableViewCell", for: indexPath) as! EventCategoryTableViewCell
        let item = viewModel.model?.categories[indexPath.row]
        cell.viewModel.model = item
        return cell
    }
}

extension EventCategoriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = categoriesTableView.cellForRow(at: indexPath) as? EventCategoryTableViewCell
        cell?.viewModel.collapseButtonTapped()
        UIView.animate(withDuration: 0.3) {
            self.categoriesTableView.performBatchUpdates(nil)
        }
    }
}

