//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

class ModelsService : BaseInfoService, InfoService {

    private let modelsPath = "/v1/car-types/main-types"
    private let manufaturerId: String
    
    init(for manufaturerId: String) {
        self.manufaturerId = manufaturerId
    }

    func load(withPage page: Int, completion: @escaping (InfoPage?) -> Void) {
        loadData(with: modelsURL(for: manufaturerId, withPage: page), completion: completion)
    }

    private func modelsURL(for manufacturer: String, withPage page: Int) -> URL {
        return URL(string: "\(host)\(modelsPath)?manufacturer=\(manufacturer)&page=\(page)&pageSize=15&\(key)")!
    }

}
