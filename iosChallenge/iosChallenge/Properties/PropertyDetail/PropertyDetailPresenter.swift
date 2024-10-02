//
//  PropertyDetailPresenter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyDetailPresenter {
    private var view: PropertyDetailViewProtocol?
    private let interactor: PropertyDetailInputInteractorProtocol?
    private let router: PropertyDetailRouterProtocol?
    
    init(view: PropertyDetailViewController, interactor: PropertyDetailInteractor, router: PropertyDetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: PropertyDetailPresenterProtocol
extension PropertyDetailPresenter: PropertyDetailPresenterProtocol {
    
}

// MARK: PropertyDetailOutputInteractorProtocol
extension PropertyDetailPresenter: PropertyDetailOutputInteractorProtocol {
    
}
