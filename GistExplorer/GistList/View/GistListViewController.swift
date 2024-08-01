//
//  ViewController.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import UIKit

class GistListViewController: UIViewController {

    private var viewModel: GistListViewModelProtocol

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(GistTableViewCell.self, forCellReuseIdentifier: "GistTableViewCell")
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "gistTableView" // Identificador para testes
        return tableView
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.accessibilityIdentifier = "loadingIndicator" // Identificador para testes
        return indicator
    }()

    init(viewModel: GistListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupTableView()
        setupViewConfiguration()
        configureNavigationBar()

        fetchData()
    }

    private func configureNavigationBar() {
        title = "Gists"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemBlue
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    private func fetchData() {
        print("Starting data fetch...")
        loadingIndicator.startAnimating()

        viewModel.fetchGists(onSuccess: {
            print("Data fetch successful.")
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }, onFailure: { error in
            print("Data fetch failed: \(error)")
            DispatchQueue.main.async {
                self.loadingIndicator.stopAnimating()
            }
        })
    }

}


extension GistListViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension GistListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GistTableViewCell", for: indexPath) as? GistTableViewCell else {
            return UITableViewCell()
        }

        let gist = viewModel.gists[indexPath.row]
        cell.configure(with: gist)
        cell.selectionStyle = .none
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.1
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 4
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedGist = viewModel.gists[indexPath.row]
        let detailViewModel = GistDetailViewModel(gist: selectedGist)
        let detailViewController = GistDetailViewController(viewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight {
            viewModel.loadMoreGists(onSuccess: {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }, onFailure: { error in
                print("Failed to load more gists: \(error)")
            })
        }
    }
}
