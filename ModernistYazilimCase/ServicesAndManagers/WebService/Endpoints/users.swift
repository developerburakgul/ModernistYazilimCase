//
//  users.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation

protocol PathProtocol {
    func getFullPath(baseURL: String) -> String
}

enum Paths: String {
    case users
    
    var endPoint: String {
        switch self {
        case .users:
            "users"
        }
    }
}

enum BaseURL: String {
    case api = "https://jsonplaceholder.typicode.com"
}

extension Paths: PathProtocol {
    func getFullPath(baseURL: String = BaseURL.api.rawValue) -> String {
        "\(baseURL)/\(self.endPoint)"
    }
}
