//
//  SplashPresenter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class SplashPresenter {
    private var view: SplashViewProtocol?
    private let interactor: SplashInputInteractorProtocol?
    private let router: SplashRouterProtocol?
    
    init(view: SplashViewController, interactor: SplashInteractor, router: SplashRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: SplashPresenterProtocol
extension SplashPresenter: SplashPresenterProtocol {
    func viewDidAppear() {
        // I have added a 1.5 seconds timer to display the splash screen,
        // because the data loading is very fast and I don't want it to appear and disappear instantly.
        Task {
            if let properties = await self.interactor?.getPropertyList() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.router?.navigateToPropertyList(propertyList: properties)
                }
            }
        }
    }
 
}

// MARK: SplashOutputInteractorProtocol
extension SplashPresenter: SplashOutputInteractorProtocol {

}
