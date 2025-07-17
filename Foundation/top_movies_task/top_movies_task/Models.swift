//
//  Models.swift
//  top_movies_task
//
//  Created by Dawid Grazawski on 12/07/2025.
//

import Foundation


struct ResultPage: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct Movie: Codable, Hashable {
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let firstAirDate: String
    let name: String
    let voteAverage: Double
    let voteCount: Int
}
