//
//  Endpoint.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

import Foundation

public enum Endpoint {
    case gistsList
    case gistDetails(id: String)

    var url: URL? {
        switch self {
        case .gistsList:
            return URL(string: "https://api.github.com/gists/public")
        case .gistDetails(let id):
            return URL(string: "https://api.github.com/gists/\(id)")
        }
    }
}
