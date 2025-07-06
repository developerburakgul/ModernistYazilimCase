//
//  LoadingState.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 7.07.2025.
//

import Foundation

public enum LoadingState<Value> {
    case idle
    case loading
    case failed(UserError)
    case loaded(Value)
}

public struct UserError{
    let title: String
    let description: String
}
