//
//  PropertyDetailPresenter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

enum DetailCellType {
    case propertyDetail(originalPropertyCode: String ,images: [ImageDetail], address: String, district: String, municipality: String, price: PriceInfoDetail, rooms: Int, size: Double, exterior: Bool, propertyType: String, operation: String, floor: String, latitude: Double, longitude: Double)
    case title(text: String)
    case propertyComment(propertyComment: String)
    case additionalPropertyInfo(text:String)
}

class PropertyDetailPresenter {
    private var view: PropertyDetailViewProtocol?
    private let interactor: PropertyDetailInputInteractorProtocol?
    private let router: PropertyDetailRouterProtocol?
    
    var propertyDetail: PropertyEntity?
    var cells: [DetailCellType] = []
    
    init(view: PropertyDetailViewController, interactor: PropertyDetailInteractor, router: PropertyDetailRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: PropertyDetailPresenterProtocol
extension PropertyDetailPresenter: PropertyDetailPresenterProtocol {
    func showMap(latitude: Double, longitude: Double) {
        self.router?.showMap(latitude: latitude, longitude: longitude)
    }
    
 
    func showFullComment(comment: String) {
        self.router?.showFullComment(comment: comment)
    }
    
    func addPropertyParameters(extraParams: ExtraParams) {
        
        self.interactor?.configureCells(property: self.propertyDetail, extraParams: extraParams)
    }
    
    func viewDidLoad() {
        Task {
            if let property = await self.interactor?.getProperty() {
                self.propertyDetail = property
                self.view?.updatePropertyEntity()
                self.interactor?.getBackButtonText()
            }
            
        }
    }
    
    
}

// MARK: PropertyDetailOutputInteractorProtocol
extension PropertyDetailPresenter: PropertyDetailOutputInteractorProtocol {
    func setBackButtonText(text: String) {
        self.view?.setBackButtonText(text: text)
    }
    
    func updateCells(cells: [DetailCellType]) {
        self.view?.updateCells(cells: cells)
    }
    
    
}
