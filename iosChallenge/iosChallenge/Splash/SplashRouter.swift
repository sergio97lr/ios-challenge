//
//  SplashRouter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class SplashRouter {
    var view: SplashViewController!

    init() {
        self.view = SplashViewController()
        let interactor = SplashInteractor()
        let presenter = SplashPresenter(view: view, interactor: interactor, router: self)
        
        self.view.presenter = presenter
        interactor.presenter = presenter
    }
    
}

// MARK: SplashRouterProtocol
extension SplashRouter: SplashRouterProtocol {
    func navigateToPropertyList(propertyList: PropertiesEntity) {
        let propertyListRouter = PropertyListRouter()
        let propertyListViewController = propertyListRouter.view
        propertyListViewController?.propertyList = propertyList
        let navigationController = UINavigationController(rootViewController: propertyListViewController!)
        
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
    }
}
