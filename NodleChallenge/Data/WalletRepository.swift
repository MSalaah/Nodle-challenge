//
//  Wallet.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation

class WalletRepository: WalletRepositoryProtocol {
    
    private let networkService: WalletServiceProviderDataSource
    
    private let cache: WalletQueriesStorage
    
    init(networkService: WalletServiceProviderDataSource, cache: WalletQueriesStorage) {
        self.networkService = networkService
        self.cache = cache
    }
    
    func fetchAllAssests(completion: @escaping (AssetsResponse) -> Void) {
        networkService.fetchAllAssests(completion: { [weak self] result in
            switch result {
            case .success(let response):
                print("Success")
//                let list = response.list
                let wallet = WalletEntity(id: "testID",title: "testTitle")
                self?.cache.addWalletData(item: wallet)
                completion(response)
            case .failure(_):
                print("Error")
//                self?.fetchLocalList(filterRequest: filterRequest, isEditable: nil, completion: completion)
            }
        })
    }
    
    func fetchWallet(walletId: String, completion: @escaping (AddressResponse) -> Void) {
        networkService.fetchWallet(walletId: walletId, completion: { [weak self] result in
            switch result {
            case .success(let response):
                print("Success")
//                let list = response.list
//                self?.cache.addList(items: list)
                completion(response)
            case .failure(_):
                print("Error")
//                self?.fetchLocalList(filterRequest: filterRequest, isEditable: nil, completion: completion)
            }
        })
    }
}
