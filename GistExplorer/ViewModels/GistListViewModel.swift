//
//  GistListViewModel.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

// MARK: - Protocol

protocol GistListViewModelProtocol {
    var gists: [GistModel] { get }
    var onGistsFetched: (([GistModel]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }

    func fetchGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
    func loadMoreGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
}

// MARK: - ViewModel

class GistListViewModel: GistListViewModelProtocol {
    private var page = 0
    private let pageSize = 20
    private let gistService: GistServiceProtocol
    public var gists: [GistModel] = []

    var onGistsFetched: (([GistModel]) -> Void)?
    var onError: ((Error) -> Void)?

    private var isLoading = false

    init(gistService: GistServiceProtocol = GistService()) {
        self.gistService = gistService
    }

    func fetchGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        guard !isLoading else { return }

        isLoading = true
        gistService.fetchGists(page: page, perPage: pageSize) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let fetchedGists):
                self?.gists.append(contentsOf: fetchedGists)
                self?.onGistsFetched?(self?.gists ?? [])
                onSuccess()
            case .failure(let error):
                print("Failed to fetch gists: \(error)")
                self?.onError?(error)
                onFailure(error)
            }
        }
    }

    func loadMoreGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        page += 1
        fetchGists(onSuccess: onSuccess, onFailure: onFailure)
    }
}
