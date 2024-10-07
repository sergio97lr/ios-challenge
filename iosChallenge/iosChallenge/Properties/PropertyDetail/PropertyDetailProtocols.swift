//
//  PropertyDetailProtocols.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

// MARK: - View to Presenter
protocol PropertyDetailPresenterProtocol {
    func viewDidLoad()
    func addPropertyParameters(extraParams: ExtraParams)
    func showFullComment(comment: String)
}

// MARK: - Presenter to View
protocol PropertyDetailViewProtocol {
    func updatePropertyEntity()
    func updateCells(cells: [DetailCellType])
    func setBackButtonText(text: String)
}

// MARK: - Presenter to Router
protocol PropertyDetailRouterProtocol {
    func showFullComment(comment: String)
}

// MARK: - Presenter to Interactor {
protocol PropertyDetailInputInteractorProtocol {
    func getProperty() async -> PropertyEntity?
    func configureCells(property: PropertyEntity?, extraParams: ExtraParams)
    func getBackButtonText()
    
}

// MARK: - Interactor to Presenter {
protocol PropertyDetailOutputInteractorProtocol {
    func updateCells(cells: [DetailCellType])
    func setBackButtonText(text: String)
}

// MARK: - CommentCell to View
protocol CommentCellDelegate: AnyObject {
    func showFullComment(comment: String)
}
