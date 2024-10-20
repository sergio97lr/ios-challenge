//
//  PriceFormatterTests.swift
//  iosChallengeTests
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge

import XCTest

class PriceFormatterTests: XCTestCase {
    
    // Test to verify price formatting in English locale
    func testFormatPriceInEnglish() throws {
        // Given
        let price = 1234567.89
        let expectedFormattedPrice = "1,234,567.89"
        
        // When
        let result = Utils.formatPrice(price)
        
        // Then
        if currentLocale().hasPrefix("en") {
            XCTAssertEqual(result, expectedFormattedPrice, "Expected formatted price in English locale is '1,234,567.89'")
        } else {
            throw XCTSkip("Locale is set to \(currentLocale()). Expected 'en'. Skipping test as the result may not be relevant.")
        }
    }
    
    // Test to verify price formatting in Spanish locale
    func testFormatPriceInSpanish() throws {
        // Given
        let price = 1234567.89
        let expectedFormattedPrice = "1.234.567,89"
        
        // When
        let result = Utils.formatPrice(price)
        
        // Then
        if currentLocale().hasPrefix("es") {
            XCTAssertEqual(result, expectedFormattedPrice, "Expected formatted price in Spanish locale is '1.234.567,89'")
        } else {
            throw XCTSkip("Locale is set to \(currentLocale()). Expected 'es'. Skipping test as the result may not be relevant.")
        }
    }
    
    // Test to verify price per square meter formatting in English locale
    func testFormatPricePerSquareMeterInEnglish() throws {
        // Given
        let value = 12345.6789
        let expectedFormattedValue = "12,345.68"
        
        // When
        let result = Utils.formatPricePerSquareMeter(value)
        
        // Then
        if currentLocale().hasPrefix("en") {
            XCTAssertEqual(result, expectedFormattedValue, "Expected formatted value in English locale is '12,345.68'")
        } else {
            throw XCTSkip("Locale is set to \(currentLocale()). Expected 'en'. Skipping test as the result may not be relevant.")
        }
    }
    
    // Test to verify price per square meter formatting in Spanish locale
    func testFormatPricePerSquareMeterInSpanish() throws {
        // Given
        let value = 12345.6789
        let expectedFormattedValue = "12.345,68"
        
        // When
        let result = Utils.formatPricePerSquareMeter(value)
        
        // Then
        if currentLocale().hasPrefix("es") {
            XCTAssertEqual(result, expectedFormattedValue, "Expected formatted value in Spanish locale is '12.345,68'")
        } else {
            throw XCTSkip("Locale is set to \(currentLocale()). Expected 'es'. Skipping test as the result may not be relevant.")
        }
    }
    
    // Helper function to determine the current locale
    private func currentLocale() -> String {
        return Locale.current.identifier
    }
}
