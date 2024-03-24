//
//  MainViewModel.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation


protocol MainViewModelOutput {
    var loading: Observable<Bool> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
    var emptyDataTitle: Observable<String> { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}

final class MainViewModel {
    
    // MARK: - OUTPUT
    let loading: Observable<Bool> = Observable(false)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    let screenTitle = NSLocalizedString("Wallet", comment: "")
    let emptyDataTitle : Observable<String> = Observable("")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    
    var onShowSpinner: (() -> Void)?
    var onHideSpinner: (() -> Void)?
    var onAssetsFetched: ((String, String) -> (Void))?
    
    
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
        walletUseCase.fetchWallet(walletId: id) { [weak self] walletResp in
            guard let item = walletResp.data.items?[0] else { return }
            let address = item.address
        }
    }
}
