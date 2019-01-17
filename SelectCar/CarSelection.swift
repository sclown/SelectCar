//  Copyright © 2019 Dmitry Kurkin. All rights reserved.

import UIKit

class CarSelection {

    var rootViewController: UINavigationController?
    
    init() {
        rootViewController = UINavigationController(rootViewController: createManufaturerSelection())
    }
    
    private func showModelSelection(for manufacturer: ItemData) {
        rootViewController?.pushViewController(createModelSelection(for: manufacturer), animated: true)
    }
    
    private func showResult(_ manufacturer: ItemData, _ model: ItemData) {
        let alert = UIAlertController(title: "Selection result",
            message: "Manufacturer: \(manufacturer.value)\nModel: \(model.value)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        rootViewController?.present(alert, animated: true, completion: nil)
    }

    private func createModelSelection(for manufacturer: ItemData) -> UIViewController {
        let service = ModelsService(for: manufacturer.key)
        let viewModel = SelectionViewModelImpl(service)
        viewModel.selectionHandler = { [weak self] item in
            self?.showResult(manufacturer, item)
        }
        let view = SelectionViewController(viewModel)
        view.title = "Choose model"
        return view
    }

    private func createManufaturerSelection() -> UIViewController {
        let service = ManufacturersService()
        let viewModel = SelectionViewModelImpl(service)
        viewModel.selectionHandler = { [weak self] item in
            self?.showModelSelection(for: item)
        }
        let view = SelectionViewController(viewModel)
        view.title = "Choose manufacturer"
        return view
    }


}


