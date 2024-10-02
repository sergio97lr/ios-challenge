//
//  PropertyListPresenter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyListPresenter {
    private var view: PropertyListViewProtocol?
    private let interactor: PropertyListInputInteractorProtocol?
    private let router: PropertyListRouterProtocol?
    
    init(view: PropertyListViewController, interactor: PropertyListInteractor, router: PropertyListRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: PropertyListPresenterProtocol
extension PropertyListPresenter: PropertyListPresenterProtocol {
    
}

// MARK: PropertyListOutputInteractorProtocol
extension PropertyListPresenter: PropertyListOutputInteractorProtocol {
    
}
