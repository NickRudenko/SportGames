//
//  EventCollectionViewCell.swift
//  Sport games
//
//  Created by Mykola Rudenko on 23.01.2022.
//

import Foundation
import UIKit

final class EventCollectionViewCell: UICollectionViewCell {
    let viewModel = EventCollectionViewCellViewModel()
    
    var reloadCollection : (() -> Void)?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let startDateContanerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
    private let startDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let favouriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let eventNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        setupBinding()
        addSubviews()
        setupConstraints()
    }
    
    private func setupBinding() {
        viewModel.startDateString.bind(to: startDateLabel.reactive.text)
        viewModel.favouriteButtonImage.bind(to: favouriteButton.reactive.image)
        viewModel.eventName.bind(to: eventNameLabel.reactive.text)
        viewModel.shouldReloadCollection.bind(to: self) {this, _ in
            guard let reloadCallback = this.reloadCollection else { return }
            reloadCallback()
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(startDateContanerView)
        startDateContanerView.addSubview(startDateLabel)
        containerView.addSubview(favouriteButton)
        containerView.addSubview(eventNameLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            startDateContanerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            startDateContanerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            startDateContanerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            startDateContanerView.heightAnchor.constraint(equalToConstant: 20),
            
            startDateLabel.topAnchor.constraint(equalTo: startDateContanerView.topAnchor, constant: 2),
            startDateLabel.bottomAnchor.constraint(equalTo: startDateContanerView.bottomAnchor, constant: -2),
            startDateLabel.leadingAnchor.constraint(equalTo: startDateContanerView.leadingAnchor, constant: 2),
            startDateLabel.trailingAnchor.constraint(equalTo: startDateContanerView.trailingAnchor, constant: -2),
            
            favouriteButton.topAnchor.constraint(equalTo: startDateContanerView.bottomAnchor, constant: 5),
            favouriteButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            favouriteButton.heightAnchor.constraint(equalToConstant: 20),
            favouriteButton.widthAnchor.constraint(equalToConstant: 20),
            
            eventNameLabel.topAnchor.constraint(equalTo: favouriteButton.bottomAnchor, constant: 5),
            eventNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            eventNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            eventNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    @objc func favouriteButtonTapped(sender: UIButton!) {
        viewModel.favouriteButtonTapped()
    }
}
