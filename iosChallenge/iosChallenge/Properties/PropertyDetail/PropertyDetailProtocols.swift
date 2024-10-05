//
//  PropertyDetailProtocols.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

// MARK: - View to Presenter
protocol PropertyDetailPresenterProtocol {
    func viewDidLoad()
    func addPropertyParameters(originalPropertyCode: String?, address: String?, district: String?, municipality: String?)
}

// MARK: - Presenter to View
protocol PropertyDetailViewProtocol {
    func updatePropertyEntity()
    func updateCells(cells: [DetailCellType])
}

// MARK: - Presenter to Router
protocol PropertyDetailRouterProtocol {
    
}

// MARK: - Presenter to Interactor {
protocol PropertyDetailInputInteractorProtocol {
    func getProperty() async -> PropertyEntity?
    func configureCells(property: PropertyEntity?)
    
}

// MARK: - Interactor to Presenter {
protocol PropertyDetailOutputInteractorProtocol {
    func updateCells(cells: [DetailCellType])
}
