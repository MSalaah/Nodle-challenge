//
//  ListTokensUseCase.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

protocol AssetsUseCassDataSource {
    func fetchAssets(completion: @escaping (AssetsResponse) -> Void)
}

final class AssetsUseCase: AssetsUseCassDataSource {
    
    private let repository: WalletRepositoryProtocol

    init(repository: WalletRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchAssets(completion: @escaping (AssetsResponse) -> Void) {
        repository.fetchAllAssests(completion: completion)
    }
}

