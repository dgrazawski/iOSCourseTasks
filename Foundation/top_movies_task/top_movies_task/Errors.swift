//
//  Errors.swift
//  top_movies_task
//
//  Created by Dawid Grazawski on 13/07/2025.
//

import Foundation


enum NetworkError: String, Error {
    case clientError = "400: Client Error"
    case serverError = "500: Server Error"
    case linkError = "Invalid Link Error"
    case invalidData = "Invalid Data Error"
    case invalidDecoding = "Invalid Decoding Error"
    case networkError = "Network Error"
}
