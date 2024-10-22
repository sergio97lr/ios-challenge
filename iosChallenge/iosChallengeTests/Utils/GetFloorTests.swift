//
//  GetFloorTests.swift
//  iosChallengeTests
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge

class GetFloorTests: XCTestCase {
    
    // Test for ground floor
    func testGetGroundFloor() {
        // Given
        let floor = "0"
        let expectedOutput = Constants.LocalizableKeys.Home.groundFloor
        
        // When
        let result = Utils.getFloor(floor: floor)
        
        // Then
        XCTAssertEqual(result, expectedOutput, "Expected ground floor string for floor '0'.")
    }
    
    // Test for first floor
    func testGetFirstFloor() {
        // Given
        let floor = "1"
        let expectedOutput = Constants.LocalizableKeys.Home.firstFloor
        
        // When
        let result = Utils.getFloor(floor: floor)
        
        // Then
        XCTAssertEqual(result, expectedOutput, "Expected first floor string for floor '1'.")
    }
    
    // Test for second floor
    func testGetSecondFloor() {
        // Given
        let floor = "2"
        let expectedOutput = Constants.LocalizableKeys.Home.secondFloor
        
        // When
        let result = Utils.getFloor(floor: floor)
        
        // Then
        XCTAssertEqual(result, expectedOutput, "Expected second floor string for floor '2'.")
    }
    
    // Test for third floor
    func testGetThirdFloor() {
        // Given
        let floor = "3"
        let expectedOutput = Constants.LocalizableKeys.Home.thirdFloor
        
        // When
        let result = Utils.getFloor(floor: floor)
        
        // Then
        XCTAssertEqual(result, expectedOutput, "Expected third floor string for floor '3'.")
    }
    
    // Test for default floor
    func testGetDefaultFloor() {
        // Given
        let floor = String(Int.random(in: 4...100))
        let expectedOutput = "\(floor)\(Constants.LocalizableKeys.Home.defaultFloor)"
        
        // When
        let result = Utils.getFloor(floor: floor)
        
        // Then
        XCTAssertEqual(result, expectedOutput, "Expected \(floor)th floor string for floor '\(floor)'.")
    }
}
