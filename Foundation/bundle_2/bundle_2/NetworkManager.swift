//
//  NetworkManager.swift
//  bundle_2
//
//  Created by Dawid Grazawski on 29/07/2025.
//

import Foundation
import UIKit


class NetworkManager {
    let url = "https://api.unsplash.com/photos"
    let accessKey = "bBVrTPxYC5lymjpvRFRmbZsVEwcaKh_t2WfNDRWUGAI"
    
    let urlSession = URLSession.shared
    
    func createURL() -> URL? {
        var components = URLComponents(string: self.url)
        components?.queryItems = [
            URLQueryItem(name: "client_id", value: accessKey)
        ]
        return components?.url
    }
    
    func fetchPhotos() async throws -> [PhotoModel] {
            guard let url = createURL() else {
                throw NetworkError.linkError
            }
            
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                throw NetworkError.invalidData
            }
            
            do {
                let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                return photos
            } catch {
                throw NetworkError.invalidDecoding
            }
        }
    
    func downloadImage(from urlString: String) async throws -> UIImage {
            guard let url = URL(string: urlString) else {
                throw NetworkError.linkError
            }
            
            let (data, response) = try await urlSession.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  200...299 ~= httpResponse.statusCode else {
                throw NetworkError.invalidData
            }
            
            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidDecoding
            }
            
            return image
        }
}
