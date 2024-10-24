//
//  PropertyListInteractor.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyListInteractor {
    
    var presenter: PropertyListOutputInteractorProtocol?
    
}

// MARK: PropertyListInputInteractorProtocol
extension PropertyListInteractor: PropertyListInputInteractorProtocol {
    func getPropertyList() async -> PropertiesEntity? {
        return await Utils.getPropertyData(type: "list") as? PropertiesEntity
    }
    
    
}
