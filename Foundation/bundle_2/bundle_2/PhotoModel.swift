//
//  PhotoModel.swift
//  bundle_2
//
//  Created by Dawid Grazawski on 29/07/2025.
//

import Foundation


class PhotoModel: Codable {
    let id: String
    let urls: [String: String]
    
    init(id: String, urls: [String : String]) {
        self.id = id
        self.urls = urls
    }
}
