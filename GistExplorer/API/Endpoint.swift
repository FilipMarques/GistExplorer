//
//  Endpoint.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

public enum Endpoint {
    case gistsList(page: Int, perPage: Int)

    var url: URL? {
        switch self {
        case .gistsList(let page, let perPage):
            let urlString = "https://api.github.com/gists/public?page=\(page)&per_page=\(perPage)"
            return URL(string: urlString)
        }
    }
}
