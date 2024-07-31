//
//  GistModel.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 29/07/24.
//

import Foundation

public struct GistModel: Codable {
    let owner: Owner
    let files: [String: File]

    struct Owner: Codable {
        let login: String
        let avatarURL: String?
        let htmlURL: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarURL = "avatar_url"
            case htmlURL = "html_url"
        }
    }

    struct File: Codable {
        let filename: String
    }

}
