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
        
        self.view.presenter = presenter
        interactor.presenter = presenter
    }
}

// MARK: PropertyDetailRouterProtocol
extension PropertyDetailRouter: PropertyDetailRouterProtocol {
    func showMap(latitude: Double, longitude: Double) {
        let mapVC = MapViewController()
        mapVC.latitude = latitude
        mapVC.longitude = longitude
        self.view.present(mapVC, animated: true, completion: nil)
    }
    
    func showFullComment(comment: String) {
        let commentViewController = PropertyCommentViewController(comment: comment)
        self.view.navigationController?.pushViewController(commentViewController, animated: true)
    }
    
    
}
