//
//  WalletRepo.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
 
protocol WalletRepositoryProtocol {
    func fetchAllAssests(completion: @escaping (AssetsResponse) -> Void)
    func fetchWallet(walletId: String, completion: @escaping (AddressResponse) -> Void)
}
