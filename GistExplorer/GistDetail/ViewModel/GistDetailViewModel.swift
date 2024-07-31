//
//  GistDetailViewModel.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 31/07/24.
//

import Foundation

protocol GistDetailViewModelProtocol {
    var gist: GistModel { get }
}

class GistDetailViewModel: GistDetailViewModelProtocol {
    var gist: GistModel

    init(gist: GistModel) {
        self.gist = gist
    }
}

