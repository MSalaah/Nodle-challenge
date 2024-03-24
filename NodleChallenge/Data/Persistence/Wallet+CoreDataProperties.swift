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
    @NSManaged public var imageUrl: String?
    @NSManaged public var icon: String?
    @NSManaged public var startTime: Date?
    @NSManaged public var endTime: Date?
    @NSManaged public var status: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var completedAt: Date?

}

extension Wallet: Identifiable {

}
