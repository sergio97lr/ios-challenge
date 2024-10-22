//
//  DateFormatterTests.swift
//  iosChallengeTests
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge

class DateFormatterTests: XCTestCase {

    // Test to verify correct time formatting
    func testFormatTime() {
        // Given
        let date = createStaticDate()
        
        // When
        let result = Utils.formatDate(date: date)
        
        // Then
        XCTAssertEqual(result.formattedTime, "21:02:59", "Expected time format is '21:02:59'")
    }
    
    // Test to verify correct date formatting
    func testFormatDate() {
        // Given
        let date = createStaticDate()
        
        // When
        let result = Utils.formatDate(date: date)
        
        // Then
        XCTAssertEqual(result.formattedDate, "03/05/2023", "Expected date format is '03/05/2023'")
    }
    
    // Helper function to create a static date
    private func createStaticDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 5
        dateComponents.day = 3
        dateComponents.hour = 21
        dateComponents.minute = 2
        dateComponents.second = 59
        let calendar = Calendar.current
        return calendar.date(from: dateComponents)!
    }
}
