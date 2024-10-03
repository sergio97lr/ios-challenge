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
}
