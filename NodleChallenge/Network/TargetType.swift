//
//  WalletApi.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
import Moya

extension TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://rest.cryptoapis.io/wallet-as-a-service/wallets") else { fatalError() }
        return url
    }
    
    var headers: [String: String]? {
        var dict: [String: String] = [:]
        dict["Content-Type"] = "application/json"
        dict["X-API-Key"] = Constants.apiKey
        return dict
    }
    
    public var validationType: ValidationType {
       return .successCodes
     }
}
