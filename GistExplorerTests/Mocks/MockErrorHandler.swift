//
//  MockErrorHandler.swift
//  GistExplorerTests
//
//  Created by Filipe Camargo Marques on 02/08/24.
//

import Foundation
@testable import GistExplorer

class MockErrorHandler: ErrorHandler {
    var handledError: Error?

    override func handleError(_ error: Error) {
        handledError = error
    }
}
