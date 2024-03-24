//
//  WalletResponse.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 23/03/2024.
//


struct AddressResponse: Codable {
    var apiVersion: String
    var requestId: String
    var data: AddressData
}

struct AddressData: Codable {
    var total: Int
    var items: [WalletAddress]?
}

struct WalletAddress: Codable {
    var address: String
    var confirmedBalance: Balance
    var createdTimestamp: Int64
}


// --------------
struct AssetsResponse: Codable {
    var apiVersion: String
    var requestId: String
    var data: AssetsData
}

struct AssetsData: Codable {
    var total: Int
    var items: [Assets]?
}

struct Assets: Codable {
    var walletId: String
    var walletName: String
}

// --------------
struct WalletResponse: Codable {
    var apiVersion: String
    var requestId: String
    var data: WalletData
}

struct WalletData: Codable {
    var item: WalletItem
}

struct WalletItem: Codable {
    var depositAddressesCount: Int64
    var fungibleTokens: [NFTokenEntity]
    var name: String
    var nonFungibleTokens: [NFTokenEntity]
    var recievedConfirmedAmount: Balance
    var sentConfirmedAmount: Balance
    var confirmedBalance: Balance
}

struct Balance: Codable {
    var amount: String
    var unit: String
}
