//
//  GistDetailViewController.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 30/07/24.
//

import UIKit

class GistDetailViewController: UIViewController, ViewConfiguration {

    private let name: String
    private let nameLabel = UILabel()

    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewConfiguration()
    }

    // MARK: - ViewConfiguration Methods

    func buildViewHierarchy() {
        view.addSubview(nameLabel)
    }

    func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func configureViews() {
        nameLabel.text = name
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}

