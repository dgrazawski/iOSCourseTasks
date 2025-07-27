//
//  Model.swift
//  bundle_3
//
//  Created by Dawid Grazawski on 27/07/2025.
//

import Foundation


class ConfigurationModel: Codable {
    let title: String
    let fontSize: CGFloat
    let darkMode: Bool
    let pictureAmmount: Int
    let trainers: [String]
}
