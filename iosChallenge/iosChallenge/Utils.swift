//
//  Utils.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import Foundation
import UIKit
import CoreData

class Utils {
    
    static func loadLocalJSON(filename: String) -> Data? {
        if let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") {
            return try? Data(contentsOf: fileURL)
        }
        return nil
    }
    
    static func getPropertyData(type: String) async -> Any? {
            let urlSession = URLSession.shared
            let urlString: String
            let filename = type

            switch type {
            case "list":
                urlString = Constants.baseUrl + Constants.listEndpoint
            case "detail":
                urlString = Constants.baseUrl + Constants.detailEndpoint
            default:
                return nil
            }
        

            let url = URL(string: urlString)!
            do {
                let (data, _) = try await urlSession.data(from: url)
                if type == "list" {
                    return try JSONDecoder().decode(PropertiesEntity.self, from: data)
                } else {
                    return try JSONDecoder().decode(PropertyEntity.self, from: data)
                }
            } catch {
                guard let localData = loadLocalJSON(filename: filename) else {
                    return nil
                }

                do {
                    if type == "list" {
                        return try JSONDecoder().decode(PropertiesEntity.self, from: localData)
                    } else {
                        return try JSONDecoder().decode(PropertyEntity.self, from: localData)
                    }
                } catch {
                    return nil
                }
            }
        }
    
    static func formatDate(date: Date) -> (formattedTime: String, formattedDate: String) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm:ss"
        let formattedTime = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        return (formattedTime, formattedDate)
    }
    
    static func formatPrice(_ precio: Double) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en")
        numberFormatter.groupingSeparator = Constants.LocalizableKeys.Price.millarSeparator
        return numberFormatter.string(from: NSNumber(value: precio))
    }
    
    static func getFloor(floor: String) -> String {
        switch floor {
        case "0":
            return Constants.LocalizableKeys.Home.groundFloor
        case "1":
            return Constants.LocalizableKeys.Home.firstFloor
        case "2":
            return Constants.LocalizableKeys.Home.secondFloor
        case "3":
            return Constants.LocalizableKeys.Home.thirdFloor
        default:
            return "\(floor)\(Constants.LocalizableKeys.Home.defaultFloor)"
        }
    }
    
    static func formatPricePerSquareMeter(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.locale = Locale(identifier: "en")
        numberFormatter.groupingSeparator = Constants.LocalizableKeys.Price.millarSeparator
        numberFormatter.decimalSeparator = Constants.LocalizableKeys.Price.decimalSeparator
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    static func isFavoriteAd(propertyCode: String) -> (codeFav: String, dateFav: Date)? {
        if CoreDataManager.shared.isFavorite(propertyCode: propertyCode) {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
            fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
            
            do {
                let results = try CoreDataManager.shared.context.fetch(fetchRequest)
                if let favorite = results.first {
                    let codeFav = favorite.value(forKey: "propertyCode") as! String
                    let dateFav = favorite.value(forKey: "favDate") as! Date
                    return (codeFav, dateFav)
                }
            } catch {
                print("Error al comprobar si es favorito: \(error)")
            }
        }
        
        return nil
    }
    
}

struct ExtraParams {
    let originalPropertyCode: String
    let address: String
    let district: String
    let municipality: String
    let parking: Bool
    let parkingIncluded: Bool
    
}

extension UITextView {
    func numberOfLines() -> Int {
        let layoutManager = self.layoutManager
        let numberOfGlyphs = layoutManager.numberOfGlyphs
        var lineRange = NSRange(location: 0, length: 0)
        var index = 0
        var numberOfLines = 0
        
        while index < numberOfGlyphs {
            layoutManager.lineFragmentRect(forGlyphAt: index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
            numberOfLines += 1
        }
        
        return numberOfLines
    }
}

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
