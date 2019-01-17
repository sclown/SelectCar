//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

@testable import SelectCar

class InfoServiceMock : BaseInfoService, InfoService {

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
    
    func load(withPage page: Int, completion: @escaping (InfoPage?) -> Void) {
        loadData(with: someURL, completion: completion)
    }

}
