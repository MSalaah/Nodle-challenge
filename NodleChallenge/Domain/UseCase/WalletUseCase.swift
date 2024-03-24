//
//  WalletUseCase.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

protocol WalletUseCaseDataSource {
    
    func fetchWallet(walletId: String, completion: @escaping (AddressResponse) -> Void)
}

final class WalletUseCase: WalletUseCaseDataSource {

    private let repository: WalletRepositoryProtocol

    init(repository: WalletRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchWallet(walletId: String, completion: @escaping (AddressResponse) -> Void) {
        repository.fetchWallet(walletId: walletId, completion: completion)
    }
}

