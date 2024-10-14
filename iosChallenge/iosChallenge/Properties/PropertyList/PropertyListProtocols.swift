//
//  PropertyListProtocols.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//


// MARK: - View to Presenter
protocol PropertyListPresenterProtocol {
    func navigateToDetail(extraParams: ExtraParams)
    func getNewPropertyList()
}

// MARK: - Presenter to View
protocol PropertyListViewProtocol {
    func reladData(property: PropertiesEntity?)
}

// MARK: - Presenter to Router
protocol PropertyListRouterProtocol {
    func navigateToDetail(extraParams: ExtraParams)
}

// MARK: - Presenter to Interactor {
protocol PropertyListInputInteractorProtocol {
    func getPropertyList() async -> PropertiesEntity?
}

// MARK: - Interactor to Presenter {
protocol PropertyListOutputInteractorProtocol {
    
}

// MARK: - PropertyAdCell to View
protocol PropertyAdCellDelegate: AnyObject {
    func navigateToDetail(extraParams: ExtraParams)
}
