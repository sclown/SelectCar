//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import UIKit

class SelectionViewModelImpl : SelectionViewModel {

    private let service: InfoService
    private var pagesCount: Int?
    private var nextPage: Int = 0
    private var data = [ItemData]()
    
    var dataHandler: (()->Void)?
    var selectionHandler: ((ItemData)->Void)?
    
    init(_ service: InfoService) {
        self.service = service
        loadMore()
    }
    
    func count() -> Int {
        return data.count
    }
    
    func item(forIndex index: Int) -> ItemModel {
        return ItemModel(data: data[index], odd: index % 2 != 0)
    }
    
    func handleSelection(_ index: Int) {
        selectionHandler?(data[index])
    }
    
    func handleScrollNearBottom() {
        loadMore()
    }
    
    private func loadMore() {
        if service.isLoading() {
            return
        }
        if pagesCount != nil && nextPage==pagesCount {
            return;
        }
        
        service.load(withPage: nextPage) { [weak self] page in
            guard let self = self else { return }
            self.handleMoreData(page)
        }
    }
    
    private func handleMoreData(_ page: InfoPage?) {
        guard let page = page else { return }
        pagesCount = page.totalPageCount
        nextPage = page.page + 1
        data.append(contentsOf:
            page.wkda.map{ ItemData(key: $0, value: $1) }.sorted{ $0.value < $1.value })
        dataHandler?()
    }
    
    

}
