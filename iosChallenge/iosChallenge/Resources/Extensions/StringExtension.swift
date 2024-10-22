//
//  StringExtension.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
