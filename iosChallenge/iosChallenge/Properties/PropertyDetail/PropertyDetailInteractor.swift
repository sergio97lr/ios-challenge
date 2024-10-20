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
        
        var operation = Constants.LocalizableKeys.Operation.sale
        if price.currencySuffix.contains("/") {
            operation = Constants.LocalizableKeys.Operation.rent
        }
        
        let latitude = property.ubication.latitude
        let longitude = property.ubication.longitude
        
        arrayCells.append(.propertyDetail(originalPropertyCode: originalPropertyCode, images: images, address: address, district: district, municipality: municipality, price: price, rooms: roomNumber, size: size, exterior: exterior, propertyType: extendedPropertyType, operation: operation, floor: floor, latitude: latitude, longitude: longitude))
        
        arrayCells.append(.title(text: Constants.LocalizableKeys.Home.advertiserComment))
        let propertyComment = property.propertyComment
        arrayCells.append(.propertyComment(propertyComment: propertyComment))
        
        arrayCells.append(.title(text: Constants.LocalizableKeys.Home.basicFeature))
        var basicFeatures: [String] = []
        let bathNumber = characteristics.bathNumber
        basicFeatures.append("\(Int(size))m\u{00B2} \(Constants.LocalizableKeys.Home.constructed)")
        basicFeatures.append("\(roomNumber) \(Constants.LocalizableKeys.Home.bedrooms)")
        basicFeatures.append("\(bathNumber) \(Constants.LocalizableKeys.Home.bathrooms)")
        
        let parking = extraParams.parking
        if parking {
            let parkingIncluded = extraParams.parkingIncluded
            if parkingIncluded {
                basicFeatures.append(Constants.LocalizableKeys.Home.parkingIncludedPrice)
            } else {
                basicFeatures.append(Constants.LocalizableKeys.Home.parkingNotIncludedPrice)
            }
        }
        
        for basicFeature in basicFeatures {
            arrayCells.append(.additionalPropertyInfo(text: basicFeature))
        }
        
        arrayCells.append(.title(text: Constants.LocalizableKeys.Home.building))
        var building: [String] = []
        if exterior {
            building.append("\(floor) \(Constants.LocalizableKeys.Home.exterior)")
        } else {
            building.append("\(floor) \(Constants.LocalizableKeys.Home.interior)")
        }
        let lift = characteristics.lift
        if lift {
            building.append(Constants.LocalizableKeys.Home.lift)
        } else {
            building.append(Constants.LocalizableKeys.Home.noLift)
        }
        
        for build in building {
            arrayCells.append(.additionalPropertyInfo(text: build))
        }
        
        arrayCells.append(.title(text: Constants.LocalizableKeys.Home.energeticCertificate))
        let consumption = property.energyCertification.energyConsumption
        let emissions = property.energyCertification.emissions
        arrayCells.append(.additionalPropertyInfo(text: "\(Constants.LocalizableKeys.Home.consumption) \(consumption.type)"))
        arrayCells.append(.additionalPropertyInfo(text: "\(Constants.LocalizableKeys.Home.emissions) \(emissions.type)"))
        
        arrayCells.append(.title(text: Constants.LocalizableKeys.Price.price))
        let priceAmount = Utils.formatPrice(price.amount)
        arrayCells.append(.additionalPropertyInfo(text: "\(priceAmount ?? "0")\(price.currencySuffix)"))
        
        let priceSize = Utils.formatPricePerSquareMeter(Double(price.amount/size))
        arrayCells.append(.additionalPropertyInfo(text: "\(priceSize) \(price.currencySuffix)/m\u{00B2}"))
        
        if extendedPropertyType.contains("flat") {
            self.backButtonText = "\(Constants.LocalizableKeys.Home.flat) \(Constants.LocalizableKeys.Others.en) \(address)"
        } else {
            self.backButtonText = "\(Constants.LocalizableKeys.Home.house) \(Constants.LocalizableKeys.Others.en) \(address)"
        }

        
        self.presenter?.updateCells(cells: arrayCells)
    }
    
    func getProperty() async -> PropertyEntity? {
        return await Utils.getPropertyData(type: "detail") as? PropertyEntity
    }
}
