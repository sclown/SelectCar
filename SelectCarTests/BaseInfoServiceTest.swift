//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import XCTest

@testable import SelectCar

fileprivate class SUT : BaseInfoService {

    let session_: URLSession
    var requestCount: Int = 0
    
    init(session: URLSession) {
        session_ = session
        super.init()
    }
    
    override func session() -> URLSession {
        requestCount += 1
        return session_
    }
}


class BaseInfoServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLoadError() {
        let sessionMock = URLSessionMock()
        sessionMock.err = NetworkError()
        let sut = SUT(session: sessionMock)
        let exp = expectation(description: "Completion in main queue")
        sut.loadData(with: someURL) { page in
            XCTAssertNil(page);
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 1)
    }
    
    func testLoadBadData() {
        let sessionMock = URLSessionMock()
        sessionMock.data = "{}".data(using: .utf8)
        
        let sut = SUT(session: sessionMock)
        let exp = expectation(description: "Completion in main queue")
        sut.loadData(with: someURL) { page in
            XCTAssertNil(page);
            exp.fulfill()
        }
        self.wait(for: [exp], timeout: 1)
    }

    func testLoadEmpty() {
        let sessionMock = URLSessionMock()
        sessionMock.data = emptyInfoJSON.data(using: .utf8)
        
        let sut = SUT(session: sessionMock)
        let exp = expectation(description: "Completion in main queue")
        sut.loadData(with: someURL) { page in
            XCTAssertNotNil(page);
            XCTAssertEqual(page!.page, 1)
            XCTAssertEqual(page!.wkda.count,0)
            exp.fulfill()
        }
        XCTAssert(sut.isLoading())
        self.wait(for: [exp], timeout: 1)
    }

}
