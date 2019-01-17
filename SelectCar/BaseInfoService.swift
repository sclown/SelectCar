//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

class BaseInfoService {
    let host = "https://api-aws-eu-qa-1.auto1-test.com"
    let key = "wa_key=coding-puzzle-client-449cc9d"
    private var dataTask: URLSessionDataTask?

    func loadData(with url: URL, completion: @escaping (InfoPage?) -> Void) {
        dataTask = session().dataTask(with: url) { [weak self] data,_,_ in
            let page = BaseInfoService.parseData(data)
            DispatchQueue.main.async {
                self?.dataTask = nil
                completion(page)
            }
        }
        dataTask?.resume()
    }
    
    func isLoading() -> Bool {
        return dataTask != nil
    }
    
    func session() -> URLSession {
        return URLSession.shared
    }
    
    private static func parseData(_ data: Data?) -> InfoPage? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(InfoPage.self, from: data)

    }
}
