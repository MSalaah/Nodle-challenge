//
//  Wallet.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation

struct WalletEntity: Codable {
    var id: String
    var title: String
    var imageUrl: String = ""
    var icon: String = ""
    var startTime: String = ""
    var endTime: String = ""
    var completedAt: String = ""
    var isCompleted: Bool = false
}

extension WalletEntity {
    func toManagedObject() -> Wallet {
        let item = Wallet()
        item.id = self.id
        item.title = self.title
        item.imageUrl = self.imageUrl
        item.icon = self.icon
        item.isCompleted = self.isCompleted
        return item
    }
}
