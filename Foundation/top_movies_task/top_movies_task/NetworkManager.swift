//
//  NetworkManager.swift
//  top_movies_task
//
//  Created by Dawid Grazawski on 13/07/2025.
//

import Foundation
import UIKit

enum URLParts: String {
    case baseUrl = "https://api.themoviedb.org/3/tv"
    case basePicUrl = "https://image.tmdb.org/t/p/w500"
    
    case apiKey = "7481bbcf1fcb56bd957cfe9af78205f3"
    
    enum Endpoints: String {
        case topRated = "/top_rated"
    }
    
    enum Parameters: String {
        case apiKey = "api_key"
        case language = "language"
        case page = "page"
    }
}

class NetworkManager {
    let dataSession: URLSession
    let picSession: URLSession
    
    init() {
        let dataConfig = URLSessionConfiguration.default
        dataConfig.timeoutIntervalForRequest = 15.0
        dataConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        self.dataSession = URLSession(configuration: dataConfig)
        
        let picConfig = URLSessionConfiguration.default
        picConfig.timeoutIntervalForRequest = 60.0
        picConfig.httpMaximumConnectionsPerHost = 20
        picConfig.requestCachePolicy = .returnCacheDataElseLoad
        self.picSession = URLSession(configuration: picConfig)
    }
    
    func buildTopRatedURL(language: String, page: Int) -> URL? {
        let urlPath = URLParts.baseUrl.rawValue + URLParts.Endpoints.topRated.rawValue
        var linkBuild = URLComponents(string: urlPath)
        linkBuild?.queryItems = [
            URLQueryItem(name: URLParts.Parameters.apiKey.rawValue, value: URLParts.apiKey.rawValue),
            URLQueryItem(name: URLParts.Parameters.language.rawValue, value: language),
            URLQueryItem(name: URLParts.Parameters.page.rawValue, value: String(page))
        ]
        return linkBuild?.url
    }
    
    func buildPicURL(bdPath: String) -> URL? {
        let urlPath = URLParts.basePicUrl.rawValue + bdPath
        let link = URL(string: urlPath)
        return link
    }
    
    func getPoster(url: URL?, completed: @escaping(Result<UIImage, NetworkError>) -> Void) {
        guard let url = url else {
            completed(.failure(.linkError))
            return
        }
        
        let task = picSession.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completed(.failure(.networkError))
                return
            }

            switch response.statusCode {
            case 200...299:
                break
            case 400...499:
                completed(.failure(.clientError))
                return
            case 500...599:
                completed(.failure(.serverError))
                return
            default:
                completed(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            guard let image = UIImage(data: data) else {
                completed(.failure(.invalidDecoding))
                return
            }
            completed(.success(image))
        }
        
        task.resume()
    }
    
    func getTopRated(url: URL?, completed: @escaping(Result<ResultPage, NetworkError>) -> Void) {
        guard let url = url else {
            completed(.failure(.linkError))
            return
        }
        
        let task = dataSession.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completed(.failure(.networkError))
                return
            }

            switch response.statusCode {
            case 200...299:
                break
            case 400...499:
                completed(.failure(.clientError))
                return
            case 500...599:
                completed(.failure(.serverError))
                return
            default:
                completed(.failure(.networkError))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let onePage = try decoder.decode(ResultPage.self, from: data)
                completed(.success(onePage))
            } catch {
                completed(.failure(.invalidDecoding))
            }
        }
        
        task.resume()
    }
    
    func invalidateAndCancel() {
        dataSession.invalidateAndCancel()
        picSession.invalidateAndCancel()
    }
}
