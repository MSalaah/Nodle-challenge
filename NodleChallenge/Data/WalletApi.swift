//
//  WalletApi.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
import Moya

enum WalletApi {
    case fetchAllAssests

    case fetchWallet(walletId: String)
}

extension WalletApi: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: Constants.baseUrl) else { fatalError() }
        return url
    }
    
    var path: String {
        switch self {
        case .fetchAllAssests:
            return "/all-assets"

        case.fetchWallet(let WalletId):
            return "/\(WalletId)/ethereum/sepolia/addresses"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .fetchWallet(let walletId):
            var params: [String: Any] = [:]
        return .requestParameters(
            parameters: params, encoding: URLEncoding.queryString)
        case .fetchAllAssests:
            return .requestPlain
        }
    }
}
