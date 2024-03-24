//
//  CoreDataWalletQueriesStorage.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation

protocol WalletQueriesStorage {
    func fetchList(completion: @escaping (([Wallet]) -> Void))
    
    func addWalletData(item: WalletEntity)
    
    func updateItem(item: WalletEntity)
}

class CoreDataWalletQueriesStorage: WalletQueriesStorage {
    func fetchList(completion: @escaping (([Wallet]) -> Void)) {
        var subPredicates: [NSPredicate] = []

        CoreDataHelper.fetchList(type: Wallet.self, predicate: NSCompoundPredicate(andPredicateWithSubpredicates: subPredicates), sortDescriptors: nil, relationshipKeysToFetch: nil) { list in
            completion(list ?? [])
        }
    }
    
    func addWalletData(item: WalletEntity) {
        let predicate = NSPredicate(format: "id = %@", argumentArray: [item.id])
        CoreDataHelper.isItemExist(type: Wallet.self, predicate: predicate) { isExist in
            if !isExist {
                _ = item.toManagedObject()
                PersistenceCoreDataHelper.saveContext()
            } else {
                self.updateItem(item: item)
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
                updatedItem?.address = item.address
                PersistenceCoreDataHelper.saveContext()
            }
        }
    }
}
