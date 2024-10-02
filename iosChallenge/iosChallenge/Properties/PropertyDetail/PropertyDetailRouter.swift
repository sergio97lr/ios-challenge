//
//  PropertyDetailRouter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyDetailRouter {
    var view: PropertyDetailViewController!

    init() {
        self.view = PropertyDetailViewController()
        let interactor = PropertyDetailInteractor()
        let presenter = PropertyDetailPresenter(view: view, interactor: interactor, router: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: PropertyDetailRouterProtocol
extension PropertyDetailRouter: PropertyDetailRouterProtocol {
    
}
