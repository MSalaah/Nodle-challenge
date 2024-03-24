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
