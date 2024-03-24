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
    var address: String = ""
    var balanceAmout: String = ""
    var balanceUnit: String = ""
    var nonFungibleTokens: [NFTokenEntity] = []
    var createdTimeStamp: Int64  = 0
}

extension WalletEntity {
    func toManagedObject() -> Wallet {
        let item = Wallet()
        item.id = self.id
        item.title = self.title
        return item
    }
}

struct WalletDetails {
    var title: String
    var value: String
}
