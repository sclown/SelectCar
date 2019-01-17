//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import XCTest

@testable import SelectCar

fileprivate class SUT : ManufacturersService {

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

class ManufacturersServiceTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoad() {
        let sessionMock = URLSessionMock()
        sessionMock.data = someJSON.data(using: .utf8)
        
        let sut = SUT(session: sessionMock)
        let exp = expectation(description: "Completion in main queue")
        sut.load(withPage: 1) { page in
            XCTAssertNotNil(page);
            XCTAssertEqual(page!.page, 1)
            XCTAssertEqual(page!.wkda.count,3)
            exp.fulfill()
        }
        XCTAssert(sut.isLoading())
        self.wait(for: [exp], timeout: 1)
    }

}
