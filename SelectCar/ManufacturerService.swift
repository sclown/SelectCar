//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

class ManufacturersService : BaseInfoService, InfoService {

    private let manufacturerPath = "/v1/car-types/manufacturer"

    func load(withPage page: Int, completion: @escaping (InfoPage?) -> Void) {
        loadData(with: manufacturerURL(withPage: page), completion: completion)
    }

    private func manufacturerURL(withPage page: Int) -> URL {
        return URL(string: "\(host)\(manufacturerPath)?page=\(page)&pageSize=15&\(key)")!
    }

}
