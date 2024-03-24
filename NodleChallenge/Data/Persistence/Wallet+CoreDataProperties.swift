//
//  Wallet+CoreDataProperties.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
import CoreData

extension Wallet {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }
    // swiftlint:disable identifier_name
    @NSManaged public var id: String
    @NSManaged public var title: String
    @NSManaged public var address: String?

}

extension Wallet: Identifiable {

}
