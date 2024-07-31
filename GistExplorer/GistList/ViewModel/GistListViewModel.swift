//
//  GistListViewModel.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

// MARK: - Protocols

protocol GistListViewModelProtocol {
    var gists: [GistModel] { get }
    var onGistsFetched: (([GistModel]) -> Void)? { get set }
    var onError: ((Error) -> Void)? { get set }

    func fetchGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
    func loadMoreGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void)
    func heightForRowAt(indexPath: IndexPath) -> CGFloat
}

// MARK: - GistListViewModel

class GistListViewModel: GistListViewModelProtocol {
    private(set) var page = 0
    private let pageSize = 20
    private let gistService: GistServiceProtocol
    private let loadingStateManager: LoadingStateManager
    private let errorHandler: ErrorHandler

    public var gists: [GistModel] = []

    var onGistsFetched: (([GistModel]) -> Void)?
    var onError: ((Error) -> Void)?

    init(
        gistService: GistServiceProtocol = GistService(),
        loadingStateManager: LoadingStateManager = LoadingStateManager(),
        errorHandler: ErrorHandler = ErrorHandler())
    {
        self.gistService = gistService
        self.loadingStateManager = loadingStateManager
        self.errorHandler = errorHandler
    }

    func fetchGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        guard !loadingStateManager.isLoading else { return }

        loadingStateManager.startLoading()
        gistService.fetchGists(page: page, perPage: pageSize) { [weak self] result in
            self?.loadingStateManager.stopLoading()
            switch result {
            case .success(let fetchedGists):
                self?.gists.append(contentsOf: fetchedGists)
                self?.onGistsFetched?(self?.gists ?? [])
                onSuccess()
            case .failure(let error):
                self?.errorHandler.handleError(error)
                self?.onError?(error)
                onFailure(error)
            }
        }
    }

    func loadMoreGists(onSuccess: @escaping () -> Void, onFailure: @escaping (Error) -> Void) {
        page += 1
        fetchGists(onSuccess: onSuccess, onFailure: onFailure)
    }

    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

