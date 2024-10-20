//
//  PropertyDetailEntitiesTests.swift
//  iosChallengeTests
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge

class PropertyDetailEntitiesTests: XCTestCase {
    // Test to verify property identification details
    func testPropertyDetailEntityIdentification() {
        // Given
        let expectedResult = PropertyDetailEntity.expectedResult()
        let mockProperty = PropertyDetailEntity.mock()
        
        // When
        let adid = mockProperty.adid
        let country = mockProperty.country
        let latitude = mockProperty.ubication.latitude
        let longitude = mockProperty.ubication.longitude
        
        // Then
        XCTAssertEqual(adid, expectedResult.adid)
        XCTAssertEqual(country, expectedResult.country)
        XCTAssertEqual(latitude, expectedResult.ubication.latitude)
        XCTAssertEqual(longitude, expectedResult.ubication.longitude)
    }
    
    // Test to verify property financial information
    func testPropertyDetailEntityFinancialInfo() {
        // Given
        let expectedResult = PropertyDetailEntity.expectedResult()
        let mockProperty = PropertyDetailEntity.mock()
        
        // When
        let price = mockProperty.price
        let priceCurrency = mockProperty.priceInfo.currencySuffix
        
        // Then
        XCTAssertEqual(price, expectedResult.price)
        XCTAssertEqual(priceCurrency, expectedResult.priceInfo.currencySuffix)
    }
    
    // Test to verify property details
    func testPropertyDetailEntityDetails() {
        // Given
        let expectedResult = PropertyDetailEntity.expectedResult()
        let mockProperty = PropertyDetailEntity.mock()
        
        // When
        let propertyType = mockProperty.propertyType
        let extendedPropertyType = mockProperty.extendedPropertyType
        let homeType = mockProperty.homeType
        let state = mockProperty.state
        let description = mockProperty.propertyComment
        
        // Then
        XCTAssertEqual(propertyType, expectedResult.propertyType)
        XCTAssertEqual(extendedPropertyType, expectedResult.extendedPropertyType)
        XCTAssertEqual(homeType, expectedResult.homeType)
        XCTAssertEqual(state, expectedResult.state)
        XCTAssertEqual(description, expectedResult.propertyComment)
    }
    
    // Test to verify property multimedia details
    func testPropertyDetailEntityMultimedia() {
        // Given
        let expectedResult = PropertyDetailEntity.expectedResult()
        let mockProperty = PropertyDetailEntity.mock()
        
        // When
        let imagesCount = mockProperty.multimedia.images.count
        let imageUrl = mockProperty.multimedia.images[0].url
        
        // Then
        XCTAssertEqual(imagesCount, expectedResult.multimedia.images.count)
        XCTAssertEqual(imageUrl, expectedResult.multimedia.images[0].url)
    }
    
    // Test to verify additional property characteristics
    func testPropertyDetailEntityMoreCharacteristics() {
        // Given
        let expectedResult = PropertyDetailEntity.expectedResult()
        let mockProperty = PropertyDetailEntity.mock()
        
        // When
        let communityCosts = mockProperty.moreCharacteristics.communityCosts
        let roomNumber = mockProperty.moreCharacteristics.roomNumber
        let bathNumber = mockProperty.moreCharacteristics.bathNumber
        let exterior = mockProperty.moreCharacteristics.exterior
        let lift = mockProperty.moreCharacteristics.lift
        let boxroom = mockProperty.moreCharacteristics.boxroom
        let isDuplex = mockProperty.moreCharacteristics.isDuplex
        let floor = mockProperty.moreCharacteristics.floor
        
        // Then
        XCTAssertEqual(communityCosts, expectedResult.moreCharacteristics.communityCosts)
        XCTAssertEqual(roomNumber, expectedResult.moreCharacteristics.roomNumber)
        XCTAssertEqual(bathNumber, expectedResult.moreCharacteristics.bathNumber)
        XCTAssertEqual(exterior, expectedResult.moreCharacteristics.exterior)
        XCTAssertEqual(lift, expectedResult.moreCharacteristics.lift)
        XCTAssertEqual(boxroom, expectedResult.moreCharacteristics.boxroom)
        XCTAssertEqual(isDuplex, expectedResult.moreCharacteristics.isDuplex)
        XCTAssertEqual(floor, expectedResult.moreCharacteristics.floor)
    }
    
    // Test to verify property energy certification details
    func testPropertyDetailEntityEnergyCertification() {
        // Given
        let expectedResult = PropertyDetailEntity.expectedResult()
        let mockProperty = PropertyDetailEntity.mock()
        
        // When
        let title = mockProperty.energyCertification.title
        let energyConsumptionType = mockProperty.energyCertification.energyConsumption.type
        let emissionsType = mockProperty.energyCertification.emissions.type
        
        // Then
        XCTAssertEqual(title, expectedResult.energyCertification.title)
        XCTAssertEqual(energyConsumptionType, expectedResult.energyCertification.energyConsumption.type)
        XCTAssertEqual(emissionsType, expectedResult.energyCertification.emissions.type)
    }
}
