//
//  PropertyDetailPresenter.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

enum DetailCellType {
    case propertyDetail(originalPropertyCode: String ,images: [ImageDetail], addres: String, district: String, municipality: String, price: PriceInfoDetail, rooms: Int, size: Double, exterior: Bool, propertyType: String, operation: String)
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
    func addPropertyParameters(originalPropertyCode: String?, address: String?, district: String?, municipality: String?) {
        self.propertyDetail?.originalPropertyCode = originalPropertyCode
        self.propertyDetail?.address = address
        self.propertyDetail?.district = district
        self.propertyDetail?.municipality = municipality
        
        self.interactor?.configureCells(property: self.propertyDetail)
    }
    
    func viewDidLoad() {
        Task {
            if let property = await self.interactor?.getProperty() {
                self.propertyDetail = property
                self.view?.updatePropertyEntity()
            }
            
        }
    }
    
    
}

// MARK: PropertyDetailOutputInteractorProtocol
extension PropertyDetailPresenter: PropertyDetailOutputInteractorProtocol {
    func updateCells(cells: [DetailCellType]) {
        self.view?.updateCells(cells: cells)
    }
    
    
}
