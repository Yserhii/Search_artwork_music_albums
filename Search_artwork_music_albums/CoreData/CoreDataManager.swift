//
//  CoreDataManager.swift
//  Search_artwork_music_albums
//
//  Created by Yolankyi SERHII on 9/10/19.
//  Copyright © 2019 Yolankyi SERHII. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    // MARK: - Singleton
    static let instance = CoreDataManager()
    
    private init() {}
    
    // MARK: - Fetched Results Controller for Entity Name
    func fetchedResultsController(entityName: String, keyForSort: String) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sortDescriptor = NSSortDescriptor(key: keyForSort, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.instance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }
    
    // MARK: - Get array with Entity Name
    func getArrayEntity(entityName: String) -> [NSManagedObject] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try  CoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            return result as! [NSManagedObject]
        } catch {
            return []
        }
    }
    
    // MARK: - Core Data stack
    lazy var managedObjectContext = persistentContainer.viewContext
    
    // MARK: - Entity for Name
    func entityForName(entityName: String) -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: self.managedObjectContext)!
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Search_artwork_music_albums")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

