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
                guard let item = response.data.items?[0] else { return }
                let wallet = WalletEntity(id: item.walletId, title: item.walletName)
                self?.cache.addWalletData(item: wallet)
                completion(response)
            case .failure(_):
                print("Working offline")
                self?.fetchFromLocal(completion: completion)
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
                print("Working offline")
//                self?.fetchLocalList(filterRequest: filterRequest, isEditable: nil, completion: completion)
            }
        })
    }
    
    private func fetchFromLocal(completion: @escaping (AssetsResponse) -> Void) {
        var arr: [Assets] = []
        cache.fetchList { list in
            let itemsList = list.map { 
                arr.append(Assets(walletId: $0.id, walletName: $0.title))
            }
            let resp = AssetsResponse(apiVersion: "Local", requestId: "LocalReq", data: AssetsData(total: itemsList.count, items: arr))
            completion(resp)
        }
    }
}
