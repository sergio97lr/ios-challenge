//
//  Utils.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 3/10/24.
//

import Foundation

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

        dateFormatter.dateFormat = "dd:MM:yyyy"
        let formattedDate = dateFormatter.string(from: date)
        
        return (formattedTime, formattedDate)
    }
    
    static func formatPrice(_ precio: Double) -> String? {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = ","
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
}
