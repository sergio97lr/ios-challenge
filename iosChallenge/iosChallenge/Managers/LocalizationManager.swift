//
//  LocalizationManager.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import Foundation
import UIKit

class LocalizationManager: NSObject {
    var bundle: Bundle!
    
    static let shared: LocalizationManager = {
        let instance = LocalizationManager()
        instance.bundle = Bundle.main
        return instance
    }()
    
    func localizedStringForKey(key: String, comment: String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func setLanguage(languageCode: String) {
        
        var language: String
        if languageCode.contains("-") {
            language = String(languageCode.prefix(2))
        } else {
            language = languageCode
        }
        UserDefaults.standard.set(language, forKey: "appLanguage")
        
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj") {
            bundle = Bundle(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
        
        Bundle.setLanguage(languageCode)
    }
    
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    func getLanguage() -> String {
        return UserDefaults.standard.string(forKey: "appLanguage") ?? Locale.preferredLanguages.first ?? "es"
    }
}
