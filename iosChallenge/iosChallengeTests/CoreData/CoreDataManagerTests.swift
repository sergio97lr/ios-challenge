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
        coreDataManager.saveFavorite(propertyCode: propertyCode)
        
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
        let propertyCode = "12345"
        
        // When
        coreDataManager.saveFavorite(propertyCode: propertyCode)
        
        // Then
        XCTAssertTrue(coreDataManager.isFavorite(propertyCode: propertyCode))
    }
    
    // Test to delete a favorite
    func testDeleteFavorite() {
        // Given
        let propertyCode = "123456"
        coreDataManager.saveFavorite(propertyCode: propertyCode)
        
        // When
        coreDataManager.deleteFavorite(propertyCode: propertyCode)
        
        // Then
        XCTAssertFalse(coreDataManager.isFavorite(propertyCode: propertyCode))
    }
    
    // Test to check if a property is favorite
    func testIsFavorite() {
        // Given
        let propertyCode = "1234567"
        coreDataManager.saveFavorite(propertyCode: propertyCode)
        
        // When
        let isFavorite = coreDataManager.isFavorite(propertyCode: propertyCode)
        
        // Then
        XCTAssertTrue(isFavorite)
    }
    
    // Test to save context with changes
    func testSaveContextWithChanges() {
        // Given
        let propertyCode = "12"
        coreDataManager.saveFavorite(propertyCode: propertyCode)
        
        // When
        coreDataManager.saveContext()
        
        // Then
        XCTAssertTrue(coreDataManager.isFavorite(propertyCode: propertyCode))
    }
    
    // Test to save context without changes
    func testSaveContextWithoutChanges() {
        // Given
        let context = coreDataManager.context
        context.processPendingChanges()  // Ensure there are no pending changes
        
        // When
        coreDataManager.saveContext()
        
        // Then
        XCTAssertNoThrow(coreDataManager.saveContext(), "Saving context without changes should not throw an error.")
    }
}
