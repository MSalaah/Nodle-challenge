//
//  BaseServiceProvider.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 21/03/2024.
//

import Foundation
import Moya

class BaseServiceProvider {
    static func request<A: TargetType, T: Decodable>(provider: MoyaProvider<A>, target: A, completion: @escaping (Result<T, NetworkableError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    if let body = response.request?.httpBody,
                          let str = String(data: body, encoding: .utf8) {
                           print("request to send: \(str))")
                       }
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    return completion(.success(results))
                } catch _ {
                    return completion(.failure(.decoding))
                }
            case let .failure(error):
                let response = error.response
                guard let statusCode = response?.statusCode else {
                    return completion(.failure(.server(description: error.localizedDescription, code: 403)))
                }
                if statusCode == 401 {
                    return completion(.failure(.unauthorized))
                }
                return completion(.failure(.server(description: error.localizedDescription, code: statusCode)))
            }
        }
    }
}
