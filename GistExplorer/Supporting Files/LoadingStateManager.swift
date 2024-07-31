//
//  LoadingStateManager.swift
//  GistExplorer
//
//  Created by Filipe Camargo Marques on 31/07/24.
//

import Foundation

class LoadingStateManager {
    private(set) var isLoading = false

    func startLoading() {
        isLoading = true
    }

    func stopLoading() {
        isLoading = false
    }
}
