//
//  NetworkableError.swift
//  NodleChallenge
//
//  Created by Moe Salah  on 22/03/2024.
//


enum NetworkableError: Error {
    case url
    case decoding
    case server(description: String, code: Int)
    case unauthorized
}

struct ListResponse<T: Codable>: Codable {
    var isEditable: Bool? = true
    var totalPageCount: Int
    var page: Int
    var list: [T]
    var allItemsCountWithSearchParams: Int? = 0
}
