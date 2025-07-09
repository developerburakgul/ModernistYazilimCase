//
//  func.swift
//  ModernistYazilimCase
//
//  Created by Burak Gül on 9.07.2025.
//

import Foundation
private var bundleKey: UInt8 = 0
extension Bundle {
    static let once: Void = {
        object_setClass(Bundle.main, PrivateBundle.self)
    }()
    
    class func setLanguage(_ language: String) {
        Bundle.once
        objc_setAssociatedObject(Bundle.main, &bundleKey, Bundle(path: Bundle.main.path(forResource: language, ofType: "lproj")!), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    private class PrivateBundle: Bundle {
        override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            let bundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle ?? self
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        }
    }
}
