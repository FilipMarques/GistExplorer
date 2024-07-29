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
    func fetchGists(completion: @escaping (Result<[GistModel], NetworkError>) -> Void)
}

public class GistService: GistServiceProtocol {
    private let apiClient: APIClient

    public init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    public func fetchGists(completion: @escaping (Result<[GistModel], NetworkError>) -> Void) {
        apiClient.request(endpoint: .gistsList, method: "GET", completion: completion)
    }
}
