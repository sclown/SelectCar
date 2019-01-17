//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import UIKit

class SelectionCell : UITableViewCell {
    static let cellId = "SelectionCell"
    static let oddColor = UIColor(white: 0.9, alpha: 1)
    static let evenColor = UIColor.white
    
    func setItem(_ item: ItemModel) {
        textLabel?.text = item.data.value
        textLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        if item.odd {
            backgroundColor = SelectionCell.oddColor
        } else {
            backgroundColor = SelectionCell.evenColor
        }
    }

}
