//
//  TableViewCell.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 30/07/24.
//

import UIKit
import Kingfisher

class GistTableViewCell: UITableViewCell {

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConfiguration()
        self.accessibilityIdentifier = "gistTableViewCell"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with gist: GistModel) {
        nameLabel.text = gist.owner.login

        if let imageUrlString = gist.owner.avatarURL,
           !imageUrlString.isEmpty,
           let url = URL(string: imageUrlString) {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "defaultProfileImage"))
        } else {
            avatarImageView.image = UIImage(named: "defaultProfileImage")
        }
    }
}

extension GistTableViewCell: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),

            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
