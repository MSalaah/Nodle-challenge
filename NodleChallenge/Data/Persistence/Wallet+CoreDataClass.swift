//
//  Wallet+CoreDataClass.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
import CoreData

@objc(Wallet)
public class Wallet: NSManagedObject {
    convenience required init() {
        let context = PersistenceCoreDataHelper.context
        self.init(context: context)
    }
    
    func toNetworkObject() -> WalletEntity {
        return WalletEntity(id: self.id, title: self.title)
    }
}
