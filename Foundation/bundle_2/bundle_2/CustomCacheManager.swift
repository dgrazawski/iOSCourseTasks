//
//  CustomCacheManager.swift
//  bundle_2
//
//  Created by Dawid Grazawski on 29/07/2025.
//

import Foundation
import UIKit


class CustomCacheManager {
    let networkManager: NetworkManager
    
    
    private let fileManager = FileManager.default
    
    private var cacheDirectory: URL {
        return fileManager.temporaryDirectory
    }
    
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMemoryWarning),
            name: UIApplication.didReceiveMemoryWarningNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func imagePath(for id: String) -> URL {
        return cacheDirectory.appendingPathComponent("\(id).jpg")
    }
    
    func isImageCached(for id: String) -> Bool {
        let path = imagePath(for: id)
        return fileManager.fileExists(atPath: path.path)
    }
    
    func loadCachedImage(for id: String) -> UIImage? {
        let path = imagePath(for: id)
        if let data = try? Data(contentsOf: path) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func saveImageToCache(_ image: UIImage, for id: String) {
        let path = imagePath(for: id)
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: path)
        }
        print("IMAGE: \(id) SAVED TO CACHE")
    }
    
    func getImage(for photo: PhotoModel) async throws -> UIImage {
        let id = photo.id
        
        // Check cache
        if isImageCached(for: id),
           let cachedImage = loadCachedImage(for: id) {
            print("IMAGE: \(id) TAKEN FROM CACHE")
            return cachedImage
        }
        
        // Otherwise download and save
        guard let urlString = photo.urls["small"] else {
            throw NetworkError.linkError
        }
        
        let image = try await networkManager.downloadImage(from: urlString)
        saveImageToCache(image, for: id)
        print("IMAGE: \(id) DOWNLOADED")
        return image
    }
    
    func clearCache() {
        var counter = 0
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectory, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                try fileManager.removeItem(at: fileURL)
                counter += 1
            }
        } catch {
            print("Error clearing cache: \(error)")
        }
        print("!!! CACHE CLEANED !!! \(counter) DELETED !!!")
    }
    
    @objc private func handleMemoryWarning() {
        clearCache()
    }
}
