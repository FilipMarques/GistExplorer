//
//  GistDetailViewController.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 30/07/24.
//

import UIKit
import Kingfisher

class GistDetailViewController: UIViewController {

    private let viewModel: GistDetailViewModelProtocol

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.systemGray4.cgColor
        imageView.backgroundColor = .systemGray5
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.25
        imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageView.layer.shadowRadius = 4
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        return label
    }()

    init(viewModel: GistDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.accessibilityIdentifier = "GistDetailViewController"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViewConfiguration()
        configureViews()
    }
}

extension GistDetailViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),

            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    func configureViews() {
        nameLabel.text = viewModel.gist.owner.login

        if let imageUrlString = viewModel.gist.owner.avatarURL,
           !imageUrlString.isEmpty,
           let url = URL(string: imageUrlString) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultProfileImage"))
        } else {
            profileImageView.image = UIImage(named: "defaultProfileImage")
        }
    }
}
