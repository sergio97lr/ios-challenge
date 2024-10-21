//
//  BundleExtension.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import Foundation

extension Bundle {
    private static var bundleKey: UInt8 = 0
    
    static func setLanguage(_ language: String) {
        defer {
            object_setClass(Bundle.main, Bundle.self)
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(forLanguage: language), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    private convenience init(forLanguage language: String) {
        var languageCode: String
            if language.contains("-") {
                languageCode = String(language.prefix(2))
            } else {
                languageCode = language
            }

        self.init(path: Bundle.main.path(forResource: languageCode, ofType: "lproj")!)!
    }
    
    @objc func swizzled_localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        let bundle = objc_getAssociatedObject(self, &Bundle.bundleKey) as? Bundle ?? self
        return bundle.swizzled_localizedString(forKey: key, value: value, table: tableName)
    }
    
    static func swizzleLocalization() {
        let originalSelector = #selector(localizedString(forKey:value:table:))
        let swizzledSelector = #selector(swizzled_localizedString(forKey:value:table:))
        
        guard let originalMethod = class_getInstanceMethod(Bundle.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(Bundle.self, swizzledSelector) else {
            return
        }
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
}

