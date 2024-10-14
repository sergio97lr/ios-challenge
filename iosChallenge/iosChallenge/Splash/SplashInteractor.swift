//
//  SplashInteractor.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class SplashInteractor {
    
    var presenter: SplashOutputInteractorProtocol?
    
}

// MARK: SplashInputInteractorProtocol
extension SplashInteractor: SplashInputInteractorProtocol {
    
    func getPropertyList() async -> PropertiesEntity? {
        return await Utils.getPropertyData(type: "list") as? PropertiesEntity
    }
}
