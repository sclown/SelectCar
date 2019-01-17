//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import XCTest

@testable import SelectCar

class SelectionViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoad() {
        let sessionMock = URLSessionMock()
        sessionMock.data = someJSON.data(using: .utf8)
        let service = InfoServiceMock(session: sessionMock)
        let sut = SelectionViewModelImpl(service)
        let exp = expectation(description: "Completion in main queue")
        sut.dataHandler = {
            XCTAssertEqual(sut.count(), 3);
            XCTAssertEqual(sut.item(forIndex: 1).data.value, "FR-V")
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 1)
    }
    
    func testMultipleScroll() {
        let sessionMock = URLSessionMock()
        sessionMock.data = someJSON.data(using: .utf8)
        let service = InfoServiceMock(session: sessionMock)
        let sut = SelectionViewModelImpl(service)
        let exp = expectation(description: "Completion in main queue")
        sut.dataHandler = {
            XCTAssertEqual(sut.count(), 3);
            XCTAssertEqual(service.requestCount, 1)
            exp.fulfill()
        }
        sut.handleScrollNearBottom()
        sut.handleScrollNearBottom()
        self.wait(for: [exp], timeout: 1)
    }

    func testNoMoreData() {
        let sessionMock = URLSessionMock()
        sessionMock.data = lastPageJSON.data(using: .utf8)
        let service = InfoServiceMock(session: sessionMock)
        let sut = SelectionViewModelImpl(service)
        let exp = expectation(description: "Completion in main queue")
        sut.dataHandler = {
            sut.handleScrollNearBottom()
            XCTAssertEqual(sut.count(), 3);
            XCTAssertEqual(service.requestCount, 1)
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 1)
    }

    func testSelectionHandler() {
        let sessionMock = URLSessionMock()
        sessionMock.data = someJSON.data(using: .utf8)
        let service = InfoServiceMock(session: sessionMock)
        let sut = SelectionViewModelImpl(service)
        let exp = expectation(description: "Completion in main queue")
        sut.dataHandler = {
            sut.handleSelection(1)
        }
        sut.selectionHandler = { item in
            XCTAssertEqual(item.key, "FR-V")
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 1)
    }
}
