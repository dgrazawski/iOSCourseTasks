//
//  GalleryDataSource.swift
//  PhotoGalleryApp
//
//  Created by Dawid Grazawski on 29/06/2025.
//

import Foundation
import UIKit

struct GalleryDataSource {
    let image: UIImage
    let title: String
    let date: String
    var isFavourite: Bool
    
    static let mockupData: [GalleryDataSource] = [
        GalleryDataSource(image: Images.trainer1, title: "Cat 1", date: "20-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer2, title: "Cat 2", date: "20-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer3, title: "Cat 3", date: "20-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer4, title: "Cat 4", date: "20-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer5, title: "Cat 5", date: "20-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer6, title: "Cat 6", date: "21-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer7, title: "Cat 7", date: "22-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer8, title: "Cat 8", date: "23-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer9, title: "Cat 9", date: "23-06-2025", isFavourite: false),
        GalleryDataSource(image: Images.trainer10, title: "Cat 10", date: "23-06-2025", isFavourite: false),
    ]
}

struct Images {
    static let trainer1 = UIImage(named: "trainer2")!
    static let trainer2 = UIImage(named: "trainer3")!
    static let trainer3 = UIImage(named: "trainer4")!
    static let trainer4 = UIImage(named: "trainer5")!
    static let trainer5 = UIImage(named: "trainer6")!
    static let trainer6 = UIImage(named: "trainer7")!
    static let trainer7 = UIImage(named: "trainer8")!
    static let trainer8 = UIImage(named: "trainer9")!
    static let trainer9 = UIImage(named: "trainer10")!
    static let trainer10 = UIImage(named: "trainer11")!
}
