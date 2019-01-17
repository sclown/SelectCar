//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

protocol InfoService {
    func load(withPage page: Int, completion: @escaping (InfoPage?)->Void)
    func isLoading() -> Bool
}

struct InfoPage : Codable {
    var page: Int
    var pageSize: Int
    var totalPageCount: Int
    var wkda: [String: String]
}
