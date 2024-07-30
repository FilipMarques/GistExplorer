//
//  GistListService.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

import Foundation

struct APIConstants {
    static let baseURL = "https://api.github.com/"
}


public protocol GistServiceProtocol {
    func fetchGists(page: Int, perPage: Int, completion: @escaping (Result<[GistModel], NetworkError>) -> Void)
}

public class GistService: GistServiceProtocol {
    private let apiClient: APIClient

    public init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    public func fetchGists(page: Int, perPage: Int, completion: @escaping (Result<[GistModel], NetworkError>) -> Void) {
        let endpoint = Endpoint.gistsList(page: page, perPage: perPage)
        apiClient.request(endpoint: endpoint, method: "GET", completion: completion)
    }
}
