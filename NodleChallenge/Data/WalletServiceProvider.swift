//
//  WalletServiceProvider.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Moya

protocol WalletServiceProviderDataSource {
    var provider: MoyaProvider<WalletApi> { get }
    
    func fetchAllAssests(completion: @escaping (Result<AssetsResponse, NetworkableError>) -> Void)
    
    func fetchWallet(walletId: String, completion: @escaping (Result<AddressResponse, NetworkableError>) -> Void)
}

class WalletServiceProvider: WalletServiceProviderDataSource {
 
    var provider = MoyaProvider<WalletApi>()
    
    func fetchAllAssests(completion: @escaping (Result<AssetsResponse, NetworkableError>) -> Void) {
        BaseServiceProvider.request(provider: provider, target: WalletApi.fetchAllAssests, completion: completion)
    }
    func fetchWallet(walletId: String, completion: @escaping (Result<AddressResponse, NetworkableError>) -> Void) {
        BaseServiceProvider.request(provider: provider, target: WalletApi.fetchWallet(walletId: walletId), completion: completion)
    }
}
