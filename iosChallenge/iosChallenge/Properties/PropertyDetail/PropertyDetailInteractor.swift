//
//  PropertyDetailInteractor.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 2/10/24.
//

import UIKit

class PropertyDetailInteractor {
    
    var presenter: PropertyDetailOutputInteractorProtocol?
    var arrayCells: [DetailCellType] = []
    
    var backButtonText = ""
}

// MARK: PropertyDetailInputInteractorProtocol
extension PropertyDetailInteractor: PropertyDetailInputInteractorProtocol {
    func getBackButtonText() {
        self.presenter?.setBackButtonText(text: self.backButtonText)
    }
    
    func configureCells(property: PropertyEntity?, extraParams: ExtraParams) {
        guard let property = property else {return}
        
        let images = property.multimedia.images
        let address = extraParams.address
        let municipality = extraParams.municipality
        let originalPropertyCode = extraParams.originalPropertyCode
        let district = extraParams.district
        
        let extendedPropertyType = property.extendedPropertyType
        let price = property.priceInfo
        let characteristics = property.moreCharacteristics
        let size = characteristics.constructedArea
        let roomNumber = characteristics.roomNumber
        let exterior = characteristics.exterior
        var floor = characteristics.floor
        floor = Utils.getFloor(floor: floor)
        
        var operation = "For Sale"
        if price.currencySuffix.contains("/") {
            operation = "For Rent"
        }
        
        arrayCells.append(.propertyDetail(originalPropertyCode: originalPropertyCode, images: images, address: address, district: district, municipality: municipality, price: price, rooms: roomNumber, size: size, exterior: exterior, propertyType: extendedPropertyType, operation: operation, floor: floor))
        
        arrayCells.append(.title(text: "Advertiser's comment"))
        let propertyComment = property.propertyComment
        arrayCells.append(.propertyComment(propertyComment: propertyComment))
        
        arrayCells.append(.title(text: "Basic features"))
        var basicFeatures: [String] = []
        let bathNumber = characteristics.bathNumber
        basicFeatures.append("\(Int(size))m\u{00B2} constructed")
        basicFeatures.append("\(roomNumber) bedrooms")
        basicFeatures.append("\(bathNumber) bathrooms")
        
        let parking = extraParams.parking
        if parking {
            let parkingIncluded = extraParams.parkingIncluded
            if parkingIncluded {
                basicFeatures.append("Parking space included in the price")
            } else {
                basicFeatures.append("Parking space not included in the price")
            }
        }
        
        for basicFeature in basicFeatures {
            arrayCells.append(.additionalPropertyInfo(text: basicFeature))
        }
        
        arrayCells.append(.title(text: "Building"))
        var building: [String] = []
        if exterior {
            building.append("\(floor) exteriro")
        } else {
            building.append("\(floor) interior")
        }
        let lift = characteristics.lift
        if lift {
            building.append("With Lift")
        } else {
            building.append("No Lift")
        }
        
        for build in building {
            arrayCells.append(.additionalPropertyInfo(text: build))
        }
        
        arrayCells.append(.title(text: "Energy performance certificate"))
        let consumption = property.energyCertification.energyConsumption
        let emissions = property.energyCertification.emissions
        arrayCells.append(.additionalPropertyInfo(text: "Consumption: \(consumption.type)"))
        arrayCells.append(.additionalPropertyInfo(text: "Emissions: \(emissions.type)"))
        
        arrayCells.append(.title(text: "Price"))
        arrayCells.append(.additionalPropertyInfo(text: "\(price.amount)\(price.currencySuffix)"))
        
        let priceSize = price.amount/size
        arrayCells.append(.additionalPropertyInfo(text: "\(priceSize) m\u{00B2}"))
        
        if extendedPropertyType.contains("flat") {
            self.backButtonText = "Flat in \(address)"
        } else {
            self.backButtonText = "House in \(address)"
        }

        
        self.presenter?.updateCells(cells: arrayCells)
    }
    
    func getProperty() async -> PropertyEntity? {
        let urlSession = URLSession.shared
        let urlString = Constants.baseUrl + Constants.listEndpoint
        let url = URL(string: urlString)!
        do {
            let (data, _) = try await urlSession.data(from: url)
            return try JSONDecoder().decode(PropertyEntity.self, from: data)
        } catch {
            guard let localData = Utils.loadLocalJSON(filename: "detail") else {
                print("No se pudo cargar el archivo JSON")
                return nil
            }

            do {
                let property = try JSONDecoder().decode(PropertyEntity.self, from: localData)
                return property
            } catch {
                print("Error al decodificar el JSON: \(error)")
                return nil
            }
        }
    }
    
    
}
