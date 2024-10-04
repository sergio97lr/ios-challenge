//
//  Favorite+CoreDataProperties.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 4/10/24.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite")
    }

    @NSManaged public var propertyCode: String?
    @NSManaged public var favDate: Date?

}

extension Favorite : Identifiable {

}
