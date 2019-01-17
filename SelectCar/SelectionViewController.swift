//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import UIKit

class SelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private(set) var model: SelectionViewModel
    private let table = UITableView()

    init(_ model: SelectionViewModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        self.model.dataHandler = { [weak self] in self?.table.reloadData() }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|-0-[table]-0-|",
                options: [],
                metrics: nil,
                views: ["table": table]
                ) + NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|-0-[table]-0-|",
                    options: [],
                    metrics: nil,
                    views: ["table": table]
            )
        )
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.delegate = self
        table.dataSource = self
        table.register(SelectionCell.self, forCellReuseIdentifier: SelectionCell.cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.cellId) as! SelectionCell
        cell.setItem(model.item(forIndex: indexPath.item))
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       if scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.height {
           model.handleScrollNearBottom()
       }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       model.handleSelection(indexPath.item)
       tableView.deselectRow(at: indexPath, animated: true)
    }

}

