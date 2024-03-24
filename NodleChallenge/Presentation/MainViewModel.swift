//
//  MainViewModel.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation

final class MainViewModel {
    
    // MARK: - OUTPUT
    var loading: Observable<Bool> = Observable(false)
    
    var details: Observable<[WalletDetails]> = Observable([])
    
    var error: Observable<String> = Observable("")
        
    var onAssetsFetched: ((String, String) -> (Void))?
    
    var walletDetails: ((WalletEntity) -> (Void))?
    var detailsArray:[WalletDetails] = []

    
    private var walletId: String?
    private let walletUseCase: WalletUseCaseDataSource
    private let assetsUseCase: AssetsUseCassDataSource
    
    init(assetsUseCase: AssetsUseCassDataSource, walletUseCase: WalletUseCaseDataSource) {
        self.walletUseCase = walletUseCase
        self.assetsUseCase = assetsUseCase
        fetchAssets()
    }
    
    private func fetchAssets() {
        self.loading.value = true
        assetsUseCase.fetchAssets { [weak self] assetsResp in
            guard let item = assetsResp.data.items?[0] else { return }
            self?.walletId = item.walletId
            self?.onAssetsFetched?(item.walletName, item.walletId)
            self?.loading.value = false
        }
    }
    
     func fetchWalletData() {
        guard let id = self.walletId else { return }
        self.loading.value = true
        walletUseCase.fetchWallet(walletId: id) { [weak self] walletResp in
            guard let item = walletResp.data.items?[0] else { return }
            let address = item.address
            let date = Date(timeIntervalSince1970: TimeInterval(item.createdTimestamp))
            let balanceAmount = item.confirmedBalance.amount
            let balanceUnit = item.confirmedBalance.unit
            
//            var wallet = WalletEntity(id: id, title: "test title")
//            wallet.address = address
//            wallet.balanceAmout = balanceAmount
//            wallet.balanceUnit = balanceUnit
//            wallet.createdTimeStamp = item.createdTimestamp
                        
            self?.detailsArray.append(WalletDetails(title: "Wallet address", value: address))
            self?.detailsArray.append(WalletDetails(title: "Wallet balance", value: balanceAmount))
            self?.detailsArray.append(WalletDetails(title: "Wallet balance Unit", value: balanceUnit))
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            let formattedDate = dateFormatter.string(from: date)

            self?.detailsArray.append(WalletDetails(title: "Creatoion Date", value: formattedDate))
            
            self?.details.value = self?.detailsArray ?? []
            self?.loading.value = false
        }
    }
}
