//
//  EventCategoryTableViewCell.swift
//  Sport games
//
//  Created by Mykola Rudenko on 22.01.2022.
//

import Foundation
import UIKit

final class EventCategoryTableViewCell: UITableViewCell {
    let viewModel = EventCategoryTableViewCellViewModel()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let eventsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "soccer_icon")
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let collapseCategoryImageView: UIImageView = {
        let button = UIImageView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    private lazy var eventsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: contentView.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: "EventCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "eventCategoryTableViewCell")
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupCell()
        setupBinding()
        addSubviews()
        setupConstraints()
    }
    
    private func setupCell() {
        backgroundColor = .mainBackgroud
        selectionStyle = .none
    }
    
    private func setupBinding() {
        viewModel.title.bind(to: titleLabel.reactive.text)
        viewModel.categoryImage.bind(to: categoryIconImageView.reactive.image)
        viewModel.isCategoryCollapsed.bind(to: eventsContainerView.reactive.isHidden)
        viewModel.collapseButtonImage.bind(to: collapseCategoryImageView.reactive.image)
        viewModel.isCategoryCollapsed.bind(to: eventsCollectionView.reactive.isHidden)
        
    }
    
    private func addSubviews() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(headerView)
        stackView.addArrangedSubview(eventsCollectionView)
        
        headerView.addSubview(categoryIconImageView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(collapseCategoryImageView)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 25),
            eventsCollectionView.heightAnchor.constraint(equalToConstant: 120),
        
            categoryIconImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 3),
            categoryIconImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -3),
            categoryIconImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 5),
            categoryIconImageView.widthAnchor.constraint(equalToConstant: 19),
            
            titleLabel.centerYAnchor.constraint(equalTo: categoryIconImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: categoryIconImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: collapseCategoryImageView.leadingAnchor, constant: -10),

            collapseCategoryImageView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
            collapseCategoryImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -5),
            collapseCategoryImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -5),
            
        ])
 
    }

}

extension EventCategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.events.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCollectionViewCell", for: indexPath) as! EventCollectionViewCell
        let item = viewModel.events.value[indexPath.row]
        cell.viewModel.model = item
        cell.reloadCollection = { [weak self] in
            self?.viewModel.setEvents()
            self?.eventsCollectionView.reloadData()
        }
        return cell
    }
}

extension EventCategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 120)
    }
}
