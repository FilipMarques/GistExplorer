//
//  GistListViewModelTests.swift
//  GistExplorerTests
//
//  Created by Filipe Camargo Marques on 31/07/24.
//

import XCTest
@testable import GistExplorer

class GistListViewModelTests: XCTestCase {

    var viewModel: GistListViewModel!
    var mockGistService: MockGistService!
    var mockLoadingStateManager: MockLoadingStateManager!
    var mockErrorHandler: MockErrorHandler!

    override func setUp() {
        super.setUp()
        mockGistService = MockGistService()
        mockLoadingStateManager = MockLoadingStateManager()
        mockErrorHandler = MockErrorHandler()

        viewModel = GistListViewModel(
            gistService: mockGistService,
            loadingStateManager: mockLoadingStateManager,
            errorHandler: mockErrorHandler
        )
    }

    override func tearDown() {
        viewModel = nil
        mockGistService = nil
        mockLoadingStateManager = nil
        mockErrorHandler = nil
        super.tearDown()
    }

    func testFetchGistsSuccess() {
        let gists = [
            GistModel(owner: GistModel.Owner(login: "owner1", avatarURL: "avatar1", htmlURL: "url1"), files: ["file1": GistModel.File(filename: "filename1")]),
            GistModel(owner: GistModel.Owner(login: "owner2", avatarURL: "avatar2", htmlURL: "url2"), files: ["file2": GistModel.File(filename: "filename2")])
        ]
        mockGistService.fetchGistsResult = .success(gists)

        let expectation = self.expectation(description: "Gists fetched")
        viewModel.onGistsFetched = { fetchedGists in
            XCTAssertEqual(fetchedGists.count, 2)
            XCTAssertEqual(fetchedGists.first?.owner.login, "owner1")
            expectation.fulfill()
        }

        viewModel.fetchGists(onSuccess: {}, onFailure: { _ in
            XCTFail("Expected success, got failure")
        })

        waitForExpectations(timeout: 1, handler: nil)
    }

    func testFetchGistsFailure() {
        let error = NSError(domain: "test", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test error"])
        mockGistService.fetchGistsResult = .failure(GistExplorer.NetworkError.noData)

        let expectation = self.expectation(description: "Gists fetch failed")

        viewModel.fetchGists(onSuccess: {
            XCTFail("Expected failure, got success")
        }, onFailure: { receivedError in
            XCTAssertEqual(receivedError.localizedDescription, GistExplorer.NetworkError.noData.localizedDescription)
            expectation.fulfill()
        })

        waitForExpectations(timeout: 1, handler: nil)
    }



    func testLoadMoreGists() {
        let initialPage = viewModel.page
        mockGistService.fetchGistsResult = .success([])

        let expectation = self.expectation(description: "Load more gists")
        viewModel.onGistsFetched = { _ in
            XCTAssertEqual(self.viewModel.page, initialPage + 1)
            expectation.fulfill()
        }

        viewModel.loadMoreGists(onSuccess: {}, onFailure: { _ in
            XCTFail("Expected success, got failure")
        })

        waitForExpectations(timeout: 1, handler: nil)
    }
}


class MockGistService: GistServiceProtocol {

    var fetchGistsResult: Result<[GistModel], GistExplorer.NetworkError>?

    func fetchGists(page: Int, perPage: Int, completion: @escaping (Result<[GistExplorer.GistModel], GistExplorer.NetworkError>) -> Void) {
        if let result = fetchGistsResult {
            completion(result)
        }
    }
}

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

class MockErrorHandler: ErrorHandler {
    var handledError: Error?

    override func handleError(_ error: Error) {
        handledError = error
    }
}
