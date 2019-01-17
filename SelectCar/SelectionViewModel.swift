//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import Foundation

class ItemData {
    var key: String
    var value: String
    init(key: String, value: String) {
        self.key = key
        self.value = value
    }
}

class ItemModel {
    var data: ItemData
    var odd: Bool
    init(data: ItemData, odd: Bool) {
        self.data = data
        self.odd = odd
    }
}

protocol SelectionViewModel {
    func count() -> Int
    func item(forIndex index: Int) -> ItemModel
    func handleSelection(_ index: Int)
    func handleScrollNearBottom()
    var dataHandler: (()->Void)? { get set }
}
