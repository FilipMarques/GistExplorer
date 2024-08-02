//
//  MockGistService.swift
//  GistExplorerTests
//
//  Created by Filipe Camargo Marques on 02/08/24.
//

@testable import GistExplorer

class MockGistService: GistServiceProtocol {

    var fetchGistsResult: Result<[GistModel], GistExplorer.NetworkError>?

    func fetchGists(page: Int, perPage: Int, completion: @escaping (Result<[GistExplorer.GistModel], GistExplorer.NetworkError>) -> Void) {
        if let result = fetchGistsResult {
            completion(result)
        }
    }
}
