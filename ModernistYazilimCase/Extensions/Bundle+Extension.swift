//
//  Bundle+Extension.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation

public extension Bundle {
    
    enum DecodeError: Error {
        case failedToLocate(file: String)
        case failedToLoad(file: String)
        case failedToDecode(file: String, targetType: String, internalError: Error)
    }
    
    func decode<T: Decodable>(
        _ type: T.Type,
        from file: String
    ) throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw(DecodeError.failedToLocate(file: file))
        }

        guard let data = try? Data(contentsOf: url) else {
            throw(DecodeError.failedToLoad(file: file))
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw(DecodeError.failedToDecode(file: file, targetType: "\(type)", internalError: error))
        }
    }
}
