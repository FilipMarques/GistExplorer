//
//  NetworkError.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

public enum NetworkError: Error {
    case urlError
    case networkError(Error)
    case noData
    case decodingError(Error)
    case unknown
}
