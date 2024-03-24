//
//  CoreDataHelper.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
import CoreData

class CoreDataHelper {
    
    static func fetchList<T>(type: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, relationshipKeysToFetch: [String]?, completion: @escaping (([T]?) -> Void)) {
        let context = PersistenceCoreDataHelper.context
        context.perform {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
            if let predicate = predicate {
                request.predicate = predicate
            }
            if let sortDescriptors = sortDescriptors {
                request.sortDescriptors = sortDescriptors
            }
            if let relationshipKeysToFetch = relationshipKeysToFetch {
                request.relationshipKeyPathsForPrefetching = relationshipKeysToFetch
            }
            do {
                let result = try context.fetch(request)
                completion(result as? [T])
            } catch {
                completion(nil)
            }
        }
    }
    
    static func fetchCount<T>(type: T.Type, predicate: NSPredicate, completion: @escaping ((Int) -> Void)) {
        let context = PersistenceCoreDataHelper.context
        context.perform {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
            request.predicate = predicate
            do {
                let result = try context.fetch(request)
                completion(result.count)
            } catch {
                completion(0)
            }
        }
    }
    
    static func isItemExist<T>(type: T.Type, predicate: NSPredicate, completion: @escaping ((Bool) -> Void)) {
        let context = PersistenceCoreDataHelper.context
        context.perform {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
            request.predicate = predicate
            do {
                let result = try context.fetch(request)
                completion(!result.isEmpty)
            } catch {
                completion(false)
            }
        }
    }
    
    static func addItem<T: NSManagedObject>(item: T, completion: @escaping ((T) -> Void)) {
        // In case not init managed object(insert it otherwise call save)
        PersistenceCoreDataHelper.context.insert(item)
        PersistenceCoreDataHelper.saveContext()
    }
    
    static func deleteItems<T: NSManagedObject>(item: T, completion: @escaping ((T) -> Void)) {
        PersistenceCoreDataHelper.context.delete(item)
        PersistenceCoreDataHelper.saveContext()
    }
    
    static func deleteAll<T>(type: T.Type) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try PersistenceCoreDataHelper.context.execute(deleteRequest)
            PersistenceCoreDataHelper.saveContext()
        } catch {
            print("There was an error")
        }
    }
    
    static func deleteList<T>(type: T.Type, predicate: NSPredicate ) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
        request.predicate = predicate
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try PersistenceCoreDataHelper.context.execute(deleteRequest)
            PersistenceCoreDataHelper.saveContext()
        } catch {
            print("There was an error")
        }
    }
}
