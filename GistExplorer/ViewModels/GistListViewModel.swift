//
//  GistListViewModel.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

class GistListViewModel {
    private let gistService: GistServiceProtocol
    public var gists: [GistModel] = []

    var onGistsFetched: (([GistModel]) -> Void)?
    var onError: ((Error) -> Void)?

    init(gistService: GistServiceProtocol = GistService()) {
        self.gistService = gistService
    }

    func fetchGists() {
        gistService.fetchGists { [weak self] result in
            switch result {
            case .success(let gists):
                self?.gists = gists
                self?.onGistsFetched?(gists)
                print("Deu certo \(gists)")
                print("")
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}

