//
//  CoreDataManagerTests.swift
//  iosChallengeTests
//
//  Created by Sergio Lopez Rosado on 20/10/24.
//

import XCTest
@testable import iosChallenge
import CoreData

class CoreDataManagerTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var mockPersistentContainer: NSPersistentContainer!
    
    override func setUp() {
        super.setUp()
        
        coreDataManager = CoreDataManager.shared
        
        // Create an in-memory persistent container for testing
        let persistentContainer = NSPersistentContainer(name: "FavoriteEntity")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        
        mockPersistentContainer = persistentContainer
        coreDataManager.context = mockPersistentContainer.viewContext
    }
    
    override func tearDown() {
        super.tearDown()
        coreDataManager = nil
        mockPersistentContainer = nil
    }
    
    // Test to verify isFavoriteAd function
    func testIsFavoriteAd() {
        // Given
        let propertyCode = "1234"
        let address = "calle Lagasca"
        let district = "Barrio Salamanca"
        let municipality = "Madrid"
        let parking = true
        let parkingIncluded = false
        let price = 1938434.0
        let currencySufix = "€"
        coreDataManager.saveFavorite(propertyCode: propertyCode, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)
        
        // When
        let result = Utils.isFavoriteAd(propertyCode: propertyCode)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.codeFav, propertyCode)
        XCTAssertNotNil(result?.dateFav)
    }
    
    // Test to save a favorite
    func testSaveFavorite() {
        // Given
        let propertyCode = "1234"
        let address = "calle Lagasca"
        let district = "Barrio Salamanca"
        let municipality = "Madrid"
        let parking = true
        let parkingIncluded = false
        let price = 1938434.0
        let currencySufix = "€"
        
        // When
        coreDataManager.saveFavorite(propertyCode: propertyCode, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)
        
        // Then
        XCTAssertTrue(coreDataManager.isFavorite(propertyCode: propertyCode))
    }
    
    // Test to delete a favorite
    func testDeleteFavorite() {
        // Given
        let propertyCode = "1234"
        let address = "calle Lagasca"
        let district = "Barrio Salamanca"
        let municipality = "Madrid"
        let parking = true
        let parkingIncluded = false
        let price = 1938434.0
        let currencySufix = "€"
        coreDataManager.saveFavorite(propertyCode: propertyCode, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)
        
        // When
        coreDataManager.deleteFavorite(propertyCode: propertyCode)
        
        // Then
        XCTAssertFalse(coreDataManager.isFavorite(propertyCode: propertyCode))
    }
    
    // Test to check if a property is favorite
    func testIsFavorite() {
        // Given
        let propertyCode = "1234"
        let address = "calle Lagasca"
        let district = "Barrio Salamanca"
        let municipality = "Madrid"
        let parking = true
        let parkingIncluded = false
        let price = 1938434.0
        let currencySufix = "€"
        coreDataManager.saveFavorite(propertyCode: propertyCode, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)
        
        // When
        let isFavorite = coreDataManager.isFavorite(propertyCode: propertyCode)
        
        // Then
        XCTAssertTrue(isFavorite)
    }
    
    // Test to fetch all favorites
        func testGetAllFavorites() {
            // Given
            let propertyCode1 = "1234"
            let propertyCode2 = "4321"
            let address = "calle Lagasca"
            let district = "Barrio Salamanca"
            let municipality = "Madrid"
            let parking = true
            let parkingIncluded = false
            let price = 1938434.0
            let currencySufix = "€"
            coreDataManager.saveFavorite(propertyCode: propertyCode1, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)
            coreDataManager.saveFavorite(propertyCode: propertyCode2, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)

            // When
            let favorites = coreDataManager.getAllFavorites()
            
            // Then
            XCTAssertEqual(favorites.count, 2)
            XCTAssertTrue(favorites.contains { $0.propertyCode == propertyCode1 })
            XCTAssertTrue(favorites.contains { $0.propertyCode == propertyCode2 })
        }
    
    // Test to save context with changes
    func testSaveContextWithChanges() {
        // Given
        let propertyCode = "1234"
        let address = "calle Lagasca"
        let district = "Barrio Salamanca"
        let municipality = "Madrid"
        let parking = true
        let parkingIncluded = false
        let price = 1938434.0
        let currencySufix = "€"
        coreDataManager.saveFavorite(propertyCode: propertyCode, favDate: Date(), address: address, district: district, municipality: municipality, parking: parking, parkingIncluded: parkingIncluded, price: price, currencySufix: currencySufix)
        
        // When
        coreDataManager.saveContext()
        
        // Then
        XCTAssertTrue(coreDataManager.isFavorite(propertyCode: propertyCode))
    }
    
    // Test to save context without changes
    func testSaveContextWithoutChanges() {
        // Given
        let context = coreDataManager.context
        context.processPendingChanges()
        
        // When
        coreDataManager.saveContext()
        
        // Then
        XCTAssertNoThrow(coreDataManager.saveContext(), "Saving context without changes should not throw an error.")
    }
}
