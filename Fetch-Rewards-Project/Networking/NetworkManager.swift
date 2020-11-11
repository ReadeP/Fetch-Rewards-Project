//
//  NetworkManager.swift
//  Fetch-Rewards-Project
//
//  Created by Reade Plunkett on 11/10/20.
//

import Foundation

enum NetworkError: LocalizedError {
    case badURL
    case badData
    case badModel
}

class NetworkManager {
    static let shared = NetworkManager()

    private let apiString = "https://fetch-hiring.s3.amazonaws.com/hiring.json"

    private init() { }

    public func getItems(completion: @escaping (Result<[Item], NetworkError>) -> ()) {
        guard let apiURL = URL(string: apiString) else {
            completion(.failure(.badURL))
            return
        }

        guard let data = try? Data(contentsOf: apiURL) else {
            completion(.failure(.badData))
            return
        }

        let decoder = JSONDecoder()

        guard let items = try? decoder.decode([Item].self, from: data) else {
            completion(.failure(.badModel))
            return
        }

        completion(.success(items))
    }
}
