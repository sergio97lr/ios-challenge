//
//  Utils.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import Foundation
import UIKit

class Utils {
    
    static func loadLocalJSON(filename: String) -> Data? {
        if let fileURL = Bundle.main.url(forResource: filename, withExtension: "json") {
            return try? Data(contentsOf: fileURL)
        }
        return nil
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
        numberFormatter.groupingSeparator = Constants.LocalizableKeys.Price.millarSeparator
        return numberFormatter.string(from: NSNumber(value: precio))
    }
    
    static func getFloor(floor: String) -> String {
        switch floor {
        case "0":
            return "ground floor"
        case "1":
            return "1st floor"
        case "2":
            return "2nd floor"
        case "3":
            return "3rd floor"
        default:
            return "\(floor)th floor"
        }
    }
    
    static func formatPricePerSquareMeter(_ value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.groupingSeparator = Constants.LocalizableKeys.Price.millarSeparator
        numberFormatter.decimalSeparator = Constants.LocalizableKeys.Price.decimalSeparator
        
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
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
