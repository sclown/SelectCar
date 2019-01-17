//  Copyright © 2019 Dmitry Kurkin. All rights reserved.
//

import Foundation

class URLSessionMock: URLSession {
    var err: Error?
    var data: Data?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, nil, self.err)
        }
    }
}

class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
    override func cancel() {
    }
    
}

class NetworkError : Error { }
