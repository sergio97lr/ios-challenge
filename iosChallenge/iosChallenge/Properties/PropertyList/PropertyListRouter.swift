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
    func navigateToDetail(propertyCode: String, address: String, district: String, municipality: String) {
        let propertyDetailRouter = PropertyDetailRouter()
        let propertyDetailView = propertyDetailRouter.view
        propertyDetailView?.originalPropertyCode = propertyCode
        propertyDetailView?.address = address
        propertyDetailView?.district = district
        propertyDetailView?.municipality = municipality
        if let propertyDetailView = propertyDetailView {
            self.view.navigationController?.pushViewController(propertyDetailView, animated: true)
        }
    }
}
