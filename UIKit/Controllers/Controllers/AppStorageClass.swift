//
//  AppStorageClass.swift
//  Controllers
//
//  Created by Dawid Grazawski on 20/06/2025.
//

import Foundation

class AppStorageClass {
    private static let storage = AppStorageClass()
    private var data: [String: String] = [:]
    
    public static subscript(_ key: String) -> String? {
        get {
            return storage.data[key]
        }
        set {
            storage.data[key] = newValue
        }
    }
    
    
}
