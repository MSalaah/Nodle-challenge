//
//  CoreDataWalletQueriesStorage.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation

protocol WalletQueriesStorage {
    func fetchList(filterRequest: String, completion: @escaping (([Wallet]) -> Void))
    
    func addList(items: [WalletEntity])
    
    func updateItem(item: WalletEntity)
}

class CoreDataWalletQueriesStorage: WalletQueriesStorage {
    func fetchList(filterRequest: String, completion: @escaping (([Wallet]) -> Void)) {
        var subPredicates: [NSPredicate] = []

        CoreDataHelper.fetchList(type: Wallet.self, predicate: NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates), sortDescriptors: nil, relationshipKeysToFetch: nil) { list in
            completion(list ?? [])
        }
    }
    
    func addList(items: [WalletEntity]) {
        if !items.isEmpty {
            for index in 0..<items.count {
                let predicate = NSPredicate(format: "id = %@", argumentArray: [items[index].id])
                CoreDataHelper.isItemExist(type: Wallet.self, predicate: predicate) { isExist in
                    if !isExist {
                        _ = items[index].toManagedObject()
                        PersistenceCoreDataHelper.saveContext()
                    } else {
                        self.updateItem(item: items[index])
                    }
                }
            }
        }
    }
    
    func updateItem(item: WalletEntity) {
        let predicate = NSPredicate(format: "id = %@", argumentArray: [item.id])
        CoreDataHelper.fetchList(type: Wallet.self, predicate: predicate, sortDescriptors: nil, relationshipKeysToFetch: nil) { fetchedItems in
            guard let fetchedItems = fetchedItems else {
                return
            }
            if !fetchedItems.isEmpty {
                let updatedItem = fetchedItems.first
                updatedItem?.title = item.title
                updatedItem?.icon = item.icon
                updatedItem?.isCompleted = item.isCompleted
                PersistenceCoreDataHelper.saveContext()
            }
        }
    }
}
