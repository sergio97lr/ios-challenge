//
//  PropertyListProtocols.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//


// MARK: - View to Presenter
protocol PropertyListPresenterProtocol {
    func navigateToDetail(propertyCode: String, address: String, district: String, municipality: String)
}

// MARK: - Presenter to View
protocol PropertyListViewProtocol {
    
}

// MARK: - Presenter to Router
protocol PropertyListRouterProtocol {
    func navigateToDetail(propertyCode: String, address: String, district: String, municipality: String)
}

// MARK: - Presenter to Interactor {
protocol PropertyListInputInteractorProtocol {
    
}

// MARK: - Interactor to Presenter {
protocol PropertyListOutputInteractorProtocol {
    
}

// MARK: - PropertyAdCell to View
protocol PropertyAdCellDelegate: AnyObject {
    func navigateToDetail(propertyCode: String, address: String, district: String, municipality: String)
}
