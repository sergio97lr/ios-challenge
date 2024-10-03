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
    
    func getPropertyList() async -> PropertiesEntity {
        let urlSession = URLSession.shared
        let urlString = Constants.baseUrl + Constants.listEndpoint
        let url = URL(string: urlString)!
        do {
            let (data, _) = try await urlSession.data(from: url)
            return try JSONDecoder().decode(PropertiesEntity.self, from: data)
        } catch {
            guard let localData = Utils.loadLocalJSON(filename: "list") else {
                print("No se pudo cargar el archivo JSON")
                return PropertiesEntity()
            }

            do {
                let properties = try JSONDecoder().decode(PropertiesEntity.self, from: localData)
                return properties
            } catch {
                print("Error al decodificar el JSON: \(error)")
                return PropertiesEntity()
            }
        }
    }
}
