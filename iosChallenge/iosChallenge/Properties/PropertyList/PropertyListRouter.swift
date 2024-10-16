//
//  PropertyListRouter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyListRouter {
    var view: PropertyListViewController!

    init() {
        self.view = PropertyListViewController()
        let interactor = PropertyListInteractor()
        let presenter = PropertyListPresenter(view: view, interactor: interactor, router: self)
        
        self.view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: PropertyListRouterProtocol
extension PropertyListRouter: PropertyListRouterProtocol {
    func navigateToDetail(extraParams: ExtraParams) {
        let propertyDetailRouter = PropertyDetailRouter()
        let propertyDetailView = propertyDetailRouter.view
        propertyDetailView?.extraParams = extraParams
        if let propertyDetailView = propertyDetailView {
            self.view.navigationController?.pushViewController(propertyDetailView, animated: true)
        }
    }
}
