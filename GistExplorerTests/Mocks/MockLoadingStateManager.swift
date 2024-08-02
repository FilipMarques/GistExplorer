//
//  MockLoadingStateManager.swift
//  GistExplorerTests
//
//  Created by Filipe Camargo Marques on 02/08/24.
//

import Foundation
@testable import GistExplorer

class MockLoadingStateManager: LoadingStateManager {
    private var _isLoading = false
    override var isLoading: Bool {
        get { return _isLoading }
        set { _isLoading = newValue }
    }

    var startLoadingCalled = false
    var stopLoadingCalled = false

    override func startLoading() {
        isLoading = true
        startLoadingCalled = true
    }

    override func stopLoading() {
        isLoading = false
        stopLoadingCalled = true
    }
}
