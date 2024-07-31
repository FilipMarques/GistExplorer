//
//  GistDetailViewModelTests.swift
//  GistExplorerTests
//
//  Created by Filipe Camargo Marques on 31/07/24.
//

import XCTest
@testable import GistExplorer

class GistDetailViewModelTests: XCTestCase {

    func testViewModelInitialization() {
        // Arrange
        let expectedOwner = GistModel.Owner(
            login: "testLogin",
            avatarURL: "http://example.com/avatar.jpg",
            htmlURL: "http://example.com"
        )
        let expectedGist = GistModel(
            owner: expectedOwner,
            files: ["file1": GistModel.File(filename: "file1.txt")]
        )

        // Act
        let viewModel = GistDetailViewModel(gist: expectedGist)

        // Assert
        XCTAssertEqual(viewModel.gist.owner.login, expectedOwner.login, "The gist login should be correctly set.")
        XCTAssertEqual(viewModel.gist.owner.avatarURL, expectedOwner.avatarURL, "The gist avatarURL should be correctly set.")
        XCTAssertEqual(viewModel.gist.owner.htmlURL, expectedOwner.htmlURL, "The gist htmlURL should be correctly set.")
        XCTAssertEqual(viewModel.gist.files["file1"]?.filename, "file1.txt", "The gist file filename should be correctly set.")
    }
}

