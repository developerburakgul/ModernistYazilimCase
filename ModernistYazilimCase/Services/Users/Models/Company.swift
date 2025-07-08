//
//  Company.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation
struct Company: Hashable, Codable{
    let name: String
    let catchPhrase: String
    let bs: String
}

extension Company {
    func convertToCompanyModel() -> CompanyModel {
        return CompanyModel(name: name, catchPhrase: catchPhrase, bs: bs)
    }
}
