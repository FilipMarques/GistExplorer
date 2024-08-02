//
//  GistListViewControllerTests.swift
//  GistExplorerUITests
//
//  Created by Filipe Camargo Marques on 01/08/24.
//

import XCTest
@testable import GistExplorer

class GistListViewControllerTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()

        // Inicializa o aplicativo para teste
        app = XCUIApplication()
        app.launchArguments.append("UITests")
        app.launch()

        // Desativa a continuidade entre testes
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
    }

    func testLoadingIndicatorVisibleDuringDataFetch() {
        let loadingIndicator = app.activityIndicators["loadingIndicator"]
        let tableView = app.tables["gistTableViewIdentifier"]

        // Verifica se o indicador de carregamento está visível
        XCTAssertTrue(loadingIndicator.waitForExistence(timeout: 10))

        // Simula a espera pelo carregamento dos dados
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        // Verifica se a tabela está visível e contém células
        XCTAssertTrue(tableView.waitForExistence(timeout: 10))
        XCTAssertGreaterThan(tableView.cells.count, 0)
    }

    func testTableViewDisplaysCellsAfterDataLoad() {
        let tableView = app.tables["gistTableViewIdentifier"]

        // Espera até que a tabela esteja visível e tenha pelo menos uma célula
        let tableExistsPredicate = NSPredicate(format: "exists == true")
        expectation(for: tableExistsPredicate, evaluatedWith: tableView, handler: nil)

        // Ajuste o tempo limite conforme necessário
        waitForExpectations(timeout: 15, handler: nil)

        // Verifica se a tabela contém pelo menos uma célula
        let cell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists, "The table view should display at least one cell after data load.")
    }


    func testCellTapNavigatesToDetailView() {
        let tableView = app.tables["gistTableViewIdentifier"]

        // Espera que a tabela e a primeira célula existam
        let cell = tableView.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 10))

        // Toca na primeira célula
        cell.tap()

        // Verifica se a tela de detalhes aparece
        let detailView = app.otherElements["GistDetailViewController"]
        XCTAssertTrue(detailView.waitForExistence(timeout: 10))
    }

    func testLoadMoreGistsOnScroll() {
        let tableView = app.tables["gistTableViewIdentifier"]

        // Verificar se a tabela está visível
        XCTAssertTrue(tableView.waitForExistence(timeout: 5))

        // Rolagem da tabela para baixo
        // Simule a rolagem até o final para acionar o carregamento adicional
        tableView.swipeUp()

        // Adicionar uma espera para permitir que novos dados sejam carregados
        let expectation = expectation(description: "Wait for new cells to appear")

        // Aguardar um tempo suficiente para novos dados serem carregados
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

        // Verificar se a tabela tem mais de uma célula (ou verificar outro comportamento esperado)
        XCTAssertGreaterThan(tableView.cells.count, 1, "Table view should have more than one cell after scrolling.")
    }

}
