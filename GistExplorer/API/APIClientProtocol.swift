//
//  APIClientProtocol.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

protocol APIClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint, method: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class APIClient: APIClientProtocol {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func request<T: Decodable>(endpoint: Endpoint, method: String = "GET", completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.urlError))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                print("Erro ao decodificar: \(error)")
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}
