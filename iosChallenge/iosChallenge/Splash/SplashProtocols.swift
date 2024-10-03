//
//  SplashProtocols.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

// MARK: - View to Presenter
protocol SplashPresenterProtocol {
    func viewDidAppear()
}

// MARK: - Presenter to View
protocol SplashViewProtocol {
    
}

// MARK: - Presenter to Router
protocol SplashRouterProtocol {
    func navigateToPropertyList(propertyList: PropertiesEntity)
}

// MARK: - Presenter to Interactor {
protocol SplashInputInteractorProtocol {
    func getPropertyList() async -> PropertiesEntity
}

// MARK: - Interactor to Presenter {
protocol SplashOutputInteractorProtocol {
    
}
