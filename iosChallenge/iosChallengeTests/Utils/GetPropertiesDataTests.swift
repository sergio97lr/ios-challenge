//
//  GetPropertiesDataTests.swift
//  iosChallengeTests
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge

class GetPropertiesDataTests: XCTestCase {
    // Test for loadLocalJSON with a valid file
    func testLoadLocalJSONValid() {
        let filename = "mockJsonEmpty"
        let data = loadJSON(filename: filename)
        XCTAssertNotNil(data, "Expected to get data, but got nil.")
    }

    // Test for loadLocalJSON with an invalid file
    func testLoadLocalJSONInvalid() {
        let filename = "InvalidFile"
        let data = loadJSON(filename: filename)
        XCTAssertNil(data, "Expected to get nil, but got data.")
    }

    // Test for getPropertyData with a valid 'list' type
    func testGetPropertyDataValidList() async {
        let jsonData = loadJSON(filename: "mockJsonList")
        XCTAssertNotNil(jsonData, "Expected jsonData to be non-nil.")
        
        guard let jsonData = jsonData else {
            XCTFail("jsonData is nil, cannot proceed with decoding.")
            return
        }
        
        let mockPropertiesEntity = try! JSONDecoder().decode(PropertiesEntity.self, from: jsonData)
        
        let data = await Utils.getPropertyData(type: "list")
        XCTAssertEqual(data as? PropertiesEntity, mockPropertiesEntity, "Expected to get a valid list of PropertyEntity.")
    }

    // Test for getPropertyData with a valid 'detail' type
    func testGetPropertyDataValidDetail() async {
        let jsonData = loadJSON(filename: "mockJsonDetail")
        XCTAssertNotNil(jsonData, "Expected jsonData to be non-nil.")
        
        guard let jsonData = jsonData else {
            XCTFail("jsonData is nil, cannot proceed with decoding.")
            return
        }
        let mockPropertyEntity = try! JSONDecoder().decode(PropertyEntity.self, from: jsonData)
        
        let data = await Utils.getPropertyData(type: "detail")
        XCTAssertEqual(data as? PropertyEntity, mockPropertyEntity, "Expected to get a valid PropertyEntity.")
    }

    // Test for getPropertyData with an invalid type
    func testGetPropertyDataInvalidType() async {
        let data = await Utils.getPropertyData(type: "invalidType")
        XCTAssertNil(data, "Expected to get nil for an invalid type.")
    }

    // Test for getPropertyData when a network error occurs
    func testGetPropertyDataNetworkError() async {
        let data = await Utils.getPropertyData(type: "list")
        XCTAssertNotNil(data, "Expected to get data from local file, but got nil.")
    }

    // Helper function to load JSON from a file
    private func loadJSON(filename: String) -> Data? {
        guard let url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json") else {
            print("JSON file not found")
            return nil
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Error loading JSON file: \(error)")
            return nil
        }
    }
}
