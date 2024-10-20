//
//  PropertyListEntitiesTests.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge

class PropertyListEntitiesTests: XCTestCase {
    // Test to verify property identification details
    func testPropertyListEntityIdentification() {
        // Given
        let expectedResult = PropertyListEntity.expectedResult()
        let mockProperty = PropertyListEntity.mock()
        
        // When
        let propertyCode = mockProperty.propertyCode
        let address = mockProperty.address
        let province = mockProperty.province
        let municipality = mockProperty.municipality
        let district = mockProperty.district
        let country = mockProperty.country
        let neighborhood = mockProperty.neighborhood
        let latitude = mockProperty.latitude
        let longitude = mockProperty.longitude
        
        // Then
        XCTAssertEqual(propertyCode, expectedResult.propertyCode)
        XCTAssertEqual(address, expectedResult.address)
        XCTAssertEqual(province, expectedResult.province)
        XCTAssertEqual(municipality, expectedResult.municipality)
        XCTAssertEqual(district, expectedResult.district)
        XCTAssertEqual(country, expectedResult.country)
        XCTAssertEqual(neighborhood, expectedResult.neighborhood)
        XCTAssertEqual(latitude, expectedResult.latitude)
        XCTAssertEqual(longitude, expectedResult.longitude)
    }
    
    // Test to verify property financial information
    func testPropertyListEntityFinancialInfo() {
        // Given
        let expectedResult = PropertyListEntity.expectedResult()
        let mockProperty = PropertyListEntity.mock()
        
        // When
        let price = mockProperty.price
        let priceCurrency = mockProperty.priceInfo.price.currencySuffix
        
        // Then
        XCTAssertEqual(price, expectedResult.price)
        XCTAssertEqual(priceCurrency, expectedResult.priceInfo.price.currencySuffix)
    }
    
    // Test to verify property details
    func testPropertyListEntityDetails() {
        // Given
        let expectedResult = PropertyListEntity.expectedResult()
        let mockProperty = PropertyListEntity.mock()
        
        // When
        let propertyType = mockProperty.propertyType
        let operation = mockProperty.operation
        let size = mockProperty.size
        let exterior = mockProperty.exterior
        let rooms = mockProperty.rooms
        let bathrooms = mockProperty.bathrooms
        let description = mockProperty.description
        
        // Then
        XCTAssertEqual(propertyType, expectedResult.propertyType)
        XCTAssertEqual(operation, expectedResult.operation)
        XCTAssertEqual(size, expectedResult.size)
        XCTAssertEqual(exterior, expectedResult.exterior)
        XCTAssertEqual(rooms, expectedResult.rooms)
        XCTAssertEqual(bathrooms, expectedResult.bathrooms)
        XCTAssertEqual(description, expectedResult.description)
    }
    
    // Test to verify property multimedia details
    func testPropertyListEntityMultimedia() {
        // Given
        let expectedResult = PropertyListEntity.expectedResult()
        let mockProperty = PropertyListEntity.mock()
        
        // When
        let thumbnail = mockProperty.thumbnail
        let imagesCount = mockProperty.multimedia.images.count
        let imageUrl = mockProperty.multimedia.images[0].url
        
        // Then
        XCTAssertEqual(thumbnail, expectedResult.thumbnail)
        XCTAssertEqual(imagesCount, expectedResult.multimedia.images.count)
        XCTAssertEqual(imageUrl, expectedResult.multimedia.images[0].url)
    }
    
    // Test to verify property features
    func testPropertyListEntityFeatures() {
        // Given
        let expectedResult = PropertyListEntity.expectedResult()
        let mockProperty = PropertyListEntity.mock()
        
        // When
        let hasAC = mockProperty.features.hasAC
        let hasBoxRoom = mockProperty.features.hasBoxRoom
        let hasTerrace = mockProperty.features.hasTerrace
        let hasGarden = mockProperty.features.hasGarden
        let hasSwimmingPool = mockProperty.features.hasSwimmingPool
        
        // Then
        XCTAssertEqual(hasAC, expectedResult.features.hasAC)
        XCTAssertEqual(hasBoxRoom, expectedResult.features.hasBoxRoom)
        XCTAssertEqual(hasTerrace, expectedResult.features.hasTerrace)
        XCTAssertEqual(hasGarden, expectedResult.features.hasGarden)
        XCTAssertEqual(hasSwimmingPool, expectedResult.features.hasSwimmingPool)
    }
    
    // Test to verify property parking space details
    func testPropertyListEntityParkingSpace() {
        // Given
        let expectedResult = PropertyListEntity.expectedResult()
        let mockProperty = PropertyListEntity.mock()
        
        // When
        let parkingSpaceExists = mockProperty.parkingSpace != nil
        let hasParkingSpace = mockProperty.parkingSpace?.hasParkingSpace
        
        // Then
        XCTAssertTrue(parkingSpaceExists)
        XCTAssertEqual(hasParkingSpace, expectedResult.parkingSpace?.hasParkingSpace)
    }
}
