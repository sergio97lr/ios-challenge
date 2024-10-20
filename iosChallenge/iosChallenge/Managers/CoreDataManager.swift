//
//  CoreDataManager.swift
//  iosChallenge
//
//  Created by Sergio Lopez Rosado on 11/10/24.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()

    var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error al guardar el contexto: \(error)")
            }
        }
    }
    
    func saveFavorite(propertyCode: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: context) else {
            print("Error: La entidad 'FavoriteEntity' no se encontró.")
            return
        }
        
        let newFavorite = NSManagedObject(entity: entity, insertInto: context)
        newFavorite.setValue(propertyCode, forKey: "propertyCode")
        newFavorite.setValue(Date(), forKey: "favDate")
        
        saveContext()
    }
    
    func deleteFavorite(propertyCode: String) {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favoriteToDelete = results.first {
                context.delete(favoriteToDelete)
                saveContext()
            }
        } catch {
            print("Error al eliminar el favorito: \(error)")
        }
    }
    
    func isFavorite(propertyCode: String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
        fetchRequest.predicate = NSPredicate(format: "propertyCode == %@", propertyCode)
        
        do {
            let results = try context.fetch(fetchRequest)
            return !results.isEmpty
        } catch {
            print("Error al comprobar si es favorito: \(error)")
            return false
        }
    }
}
